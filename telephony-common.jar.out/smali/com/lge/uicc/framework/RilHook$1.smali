.class Lcom/lge/uicc/framework/RilHook$1;
.super Lcom/lge/uicc/framework/RilHook$Hook;
.source "RilHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lge/uicc/framework/RilHook;->handleIccIOForApp(IILjava/lang/String;IIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)Landroid/os/Message;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/uicc/framework/RilHook;


# direct methods
.method constructor <init>(Lcom/lge/uicc/framework/RilHook;Landroid/os/Message;)V
    .locals 0
    .param p2, "x0"    # Landroid/os/Message;

    .prologue
    .line 147
    iput-object p1, p0, Lcom/lge/uicc/framework/RilHook$1;->this$0:Lcom/lge/uicc/framework/RilHook;

    invoke-direct {p0, p1, p2}, Lcom/lge/uicc/framework/RilHook$Hook;-><init>(Lcom/lge/uicc/framework/RilHook;Landroid/os/Message;)V

    return-void
.end method


# virtual methods
.method handleResult(Landroid/os/AsyncResult;)Landroid/os/Message;
    .locals 4
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    .line 149
    iget-object v2, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v2, :cond_0

    .line 150
    iget-object v1, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v1, Lcom/android/internal/telephony/uicc/IccIoResult;

    .line 151
    .local v1, "ioresult":Lcom/android/internal/telephony/uicc/IccIoResult;
    iget-object v2, v1, Lcom/android/internal/telephony/uicc/IccIoResult;->payload:[B

    invoke-static {v2}, Lcom/lge/uicc/EfUtils;->bcdToString([B)Ljava/lang/String;

    move-result-object v0

    .line 152
    .local v0, "iccid":Ljava/lang/String;
    iget-object v2, p0, Lcom/lge/uicc/framework/RilHook$1;->this$0:Lcom/lge/uicc/framework/RilHook;

    # getter for: Lcom/lge/uicc/framework/RilHook;->mSlotId:I
    invoke-static {v2}, Lcom/lge/uicc/framework/RilHook;->access$000(Lcom/lge/uicc/framework/RilHook;)I

    move-result v2

    invoke-static {v0, v2}, Lcom/lge/uicc/framework/IccidHandler;->handleGetIccidDone(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_0

    .line 153
    iget-object v2, p0, Lcom/lge/uicc/framework/RilHook$1;->this$0:Lcom/lge/uicc/framework/RilHook;

    const-string v3, "report fail to load iccid"

    invoke-virtual {v2, v3}, Lcom/lge/uicc/framework/RilHook;->logd(Ljava/lang/String;)V

    .line 154
    iget-object v2, p0, Lcom/lge/uicc/framework/RilHook$1;->this$0:Lcom/lge/uicc/framework/RilHook;

    iget-object v2, v2, Lcom/lge/uicc/framework/RilHook;->RESPONSE_GENERIC_FAILURE:Lcom/android/internal/telephony/CommandException;

    iput-object v2, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    .line 157
    .end local v0    # "iccid":Ljava/lang/String;
    .end local v1    # "ioresult":Lcom/android/internal/telephony/uicc/IccIoResult;
    :cond_0
    invoke-super {p0, p1}, Lcom/lge/uicc/framework/RilHook$Hook;->handleResult(Landroid/os/AsyncResult;)Landroid/os/Message;

    move-result-object v2

    return-object v2
.end method
