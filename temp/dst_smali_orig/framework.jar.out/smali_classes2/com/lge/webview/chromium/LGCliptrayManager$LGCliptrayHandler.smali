.class Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayHandler;
.super Landroid/os/Handler;
.source "LGCliptrayManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/webview/chromium/LGCliptrayManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "LGCliptrayHandler"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/webview/chromium/LGCliptrayManager;


# direct methods
.method private constructor <init>(Lcom/lge/webview/chromium/LGCliptrayManager;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayHandler;->this$0:Lcom/lge/webview/chromium/LGCliptrayManager;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/lge/webview/chromium/LGCliptrayManager;Lcom/lge/webview/chromium/LGCliptrayManager$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/lge/webview/chromium/LGCliptrayManager;
    .param p2, "x1"    # Lcom/lge/webview/chromium/LGCliptrayManager$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayHandler;-><init>(Lcom/lge/webview/chromium/LGCliptrayManager;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 2
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    :goto_0
    return-void

    :pswitch_0
    iget-object v0, p0, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayHandler;->this$0:Lcom/lge/webview/chromium/LGCliptrayManager;

    # invokes: Lcom/lge/webview/chromium/LGCliptrayManager;->pasteFromCliptray()V
    invoke-static {v0}, Lcom/lge/webview/chromium/LGCliptrayManager;->access$100(Lcom/lge/webview/chromium/LGCliptrayManager;)V

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayHandler;->this$0:Lcom/lge/webview/chromium/LGCliptrayManager;

    # getter for: Lcom/lge/webview/chromium/LGCliptrayManager;->mCliptrayManager:Lcom/lge/systemservice/core/CliptrayManager;
    invoke-static {v0}, Lcom/lge/webview/chromium/LGCliptrayManager;->access$200(Lcom/lge/webview/chromium/LGCliptrayManager;)Lcom/lge/systemservice/core/CliptrayManager;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayHandler;->this$0:Lcom/lge/webview/chromium/LGCliptrayManager;

    # getter for: Lcom/lge/webview/chromium/LGCliptrayManager;->mCliptrayManager:Lcom/lge/systemservice/core/CliptrayManager;
    invoke-static {v0}, Lcom/lge/webview/chromium/LGCliptrayManager;->access$200(Lcom/lge/webview/chromium/LGCliptrayManager;)Lcom/lge/systemservice/core/CliptrayManager;

    move-result-object v1

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Ljava/lang/CharSequence;

    invoke-virtual {v1, v0}, Lcom/lge/systemservice/core/CliptrayManager;->copyToCliptray(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_0
    const-string v0, "LGCliptrayManager"

    const-string v1, "LGCliptrayHandler::LGCLIPTRAY_COPY_TEXT: mCliptrayManager is null or not connected"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :pswitch_2
    iget-object v0, p0, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayHandler;->this$0:Lcom/lge/webview/chromium/LGCliptrayManager;

    # getter for: Lcom/lge/webview/chromium/LGCliptrayManager;->mCliptrayManager:Lcom/lge/systemservice/core/CliptrayManager;
    invoke-static {v0}, Lcom/lge/webview/chromium/LGCliptrayManager;->access$200(Lcom/lge/webview/chromium/LGCliptrayManager;)Lcom/lge/systemservice/core/CliptrayManager;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayHandler;->this$0:Lcom/lge/webview/chromium/LGCliptrayManager;

    # getter for: Lcom/lge/webview/chromium/LGCliptrayManager;->mCliptrayManager:Lcom/lge/systemservice/core/CliptrayManager;
    invoke-static {v0}, Lcom/lge/webview/chromium/LGCliptrayManager;->access$200(Lcom/lge/webview/chromium/LGCliptrayManager;)Lcom/lge/systemservice/core/CliptrayManager;

    move-result-object v1

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/net/Uri;

    invoke-virtual {v1, v0}, Lcom/lge/systemservice/core/CliptrayManager;->copyImageToCliptray(Landroid/net/Uri;)V

    goto :goto_0

    :cond_1
    const-string v0, "LGCliptrayManager"

    const-string v1, "LGCliptrayHandler::LGCLIPTRAY_COPY_IMAGE: mCliptrayManager is null or not connected"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :pswitch_3
    iget-object v0, p0, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayHandler;->this$0:Lcom/lge/webview/chromium/LGCliptrayManager;

    # getter for: Lcom/lge/webview/chromium/LGCliptrayManager;->mCliptrayManager:Lcom/lge/systemservice/core/CliptrayManager;
    invoke-static {v0}, Lcom/lge/webview/chromium/LGCliptrayManager;->access$200(Lcom/lge/webview/chromium/LGCliptrayManager;)Lcom/lge/systemservice/core/CliptrayManager;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayHandler;->this$0:Lcom/lge/webview/chromium/LGCliptrayManager;

    # getter for: Lcom/lge/webview/chromium/LGCliptrayManager;->mCliptrayManager:Lcom/lge/systemservice/core/CliptrayManager;
    invoke-static {v0}, Lcom/lge/webview/chromium/LGCliptrayManager;->access$200(Lcom/lge/webview/chromium/LGCliptrayManager;)Lcom/lge/systemservice/core/CliptrayManager;

    move-result-object v1

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/content/ClipData;

    invoke-virtual {v1, v0}, Lcom/lge/systemservice/core/CliptrayManager;->copyToCliptray(Landroid/content/ClipData;)V

    goto :goto_0

    :cond_2
    const-string v0, "LGCliptrayManager"

    const-string v1, "LGCliptrayHandler::LGCLIPTRAY_COPY_DATA: mCliptrayManager is null or not connected"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method
