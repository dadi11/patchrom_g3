.class Lcom/android/internal/telephony/SingleBinary$1;
.super Ljava/lang/Object;
.source "SingleBinary.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/SingleBinary;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/SingleBinary;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/SingleBinary;)V
    .locals 0

    .prologue
    .line 128
    iput-object p1, p0, Lcom/android/internal/telephony/SingleBinary$1;->this$0:Lcom/android/internal/telephony/SingleBinary;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 131
    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary$1;->this$0:Lcom/android/internal/telephony/SingleBinary;

    # getter for: Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;
    invoke-static {v0}, Lcom/android/internal/telephony/SingleBinary;->access$000(Lcom/android/internal/telephony/SingleBinary;)Landroid/app/AlertDialog;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary$1;->this$0:Lcom/android/internal/telephony/SingleBinary;

    # getter for: Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;
    invoke-static {v0}, Lcom/android/internal/telephony/SingleBinary;->access$000(Lcom/android/internal/telephony/SingleBinary;)Landroid/app/AlertDialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 132
    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary$1;->this$0:Lcom/android/internal/telephony/SingleBinary;

    # invokes: Lcom/android/internal/telephony/SingleBinary;->rebootSystem()V
    invoke-static {v0}, Lcom/android/internal/telephony/SingleBinary;->access$100(Lcom/android/internal/telephony/SingleBinary;)V

    .line 134
    :cond_0
    return-void
.end method