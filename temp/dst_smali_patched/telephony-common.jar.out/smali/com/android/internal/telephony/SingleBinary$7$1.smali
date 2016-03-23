.class Lcom/android/internal/telephony/SingleBinary$7$1;
.super Ljava/lang/Object;
.source "SingleBinary.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/android/internal/telephony/SingleBinary$7;->onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/android/internal/telephony/SingleBinary$7;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/SingleBinary$7;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/SingleBinary$7$1;->this$1:Lcom/android/internal/telephony/SingleBinary$7;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .prologue
    const/4 v0, -0x1

    if-ne p2, v0, :cond_1

    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary$7$1;->this$1:Lcom/android/internal/telephony/SingleBinary$7;

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary$7;->this$0:Lcom/android/internal/telephony/SingleBinary;

    # getter for: Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;
    invoke-static {v0}, Lcom/android/internal/telephony/SingleBinary;->access$1400(Lcom/android/internal/telephony/SingleBinary;)Landroid/widget/TextView;

    move-result-object v0

    if-eqz v0, :cond_0

    # getter for: Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;
    invoke-static {}, Lcom/android/internal/telephony/SingleBinary;->access$1000()Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_0

    # getter for: Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;
    invoke-static {}, Lcom/android/internal/telephony/SingleBinary;->access$1000()Landroid/content/Context;

    move-result-object v0

    # getter for: Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;
    invoke-static {}, Lcom/android/internal/telephony/SingleBinary;->access$1000()Landroid/content/Context;

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/android/internal/telephony/SingleBinary$7$1;->this$1:Lcom/android/internal/telephony/SingleBinary$7;

    iget-object v1, v1, Lcom/android/internal/telephony/SingleBinary$7;->this$0:Lcom/android/internal/telephony/SingleBinary;

    # getter for: Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;
    invoke-static {v1}, Lcom/android/internal/telephony/SingleBinary;->access$1400(Lcom/android/internal/telephony/SingleBinary;)Landroid/widget/TextView;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary$7$1;->this$1:Lcom/android/internal/telephony/SingleBinary$7;

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary$7;->this$0:Lcom/android/internal/telephony/SingleBinary;

    const/4 v1, 0x0

    # setter for: Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;
    invoke-static {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->access$1402(Lcom/android/internal/telephony/SingleBinary;Landroid/widget/TextView;)Landroid/widget/TextView;

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    goto :goto_0
.end method
