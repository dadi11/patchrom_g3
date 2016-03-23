.class Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;
.super Landroid/os/Handler;
.source "SecurityManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;)V
    .locals 0

    .prologue
    .line 148
    iput-object p1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v3, 0x0

    .line 153
    iget v1, p1, Landroid/os/Message;->what:I

    sparse-switch v1, :sswitch_data_0

    .line 224
    const-string v1, "SecurityManager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "handleMessage: unexpected message code: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 227
    :goto_0
    return-void

    .line 155
    :sswitch_0
    const-string v1, "SecurityManager"

    const-string v2, "handleMessage : SECURITY_PROCESS_COMMAND_PERSONALIZATION_INFORMATION"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 156
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 157
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v1, :cond_0

    iget-object v1, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v1, :cond_0

    .line 158
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iget-object v2, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    iput-object v2, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->response:Ljava/lang/Object;

    .line 164
    :goto_1
    iget-object v2, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    monitor-enter v2

    .line 166
    :try_start_0
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    const/4 v3, 0x1

    # setter for: Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->mDone:Z
    invoke-static {v1, v3}, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->access$102(Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;Z)Z

    .line 167
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 168
    monitor-exit v2

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    .line 160
    :cond_0
    const-string v1, "SecurityManager"

    const-string v2, "handleMessage: Faile"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 161
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iput-object v3, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->response:Ljava/lang/Object;

    goto :goto_1

    .line 171
    .end local v0    # "ar":Landroid/os/AsyncResult;
    :sswitch_1
    const-string v1, "SecurityManager"

    const-string v2, "handleMessage : SECURITY_PROCESS_COMMAND_DEPERSONALIZATION"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 172
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 173
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v1, :cond_1

    iget-object v1, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v1, :cond_1

    .line 174
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iget-object v2, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    iput-object v2, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->response:Ljava/lang/Object;

    .line 175
    const-string v1, "SecurityManager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "handleMessage : SECURITY_PROCESS_COMMAND_DEPERSONALIZATION("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    iget-object v3, v3, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iget-object v3, v3, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->response:Ljava/lang/Object;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 181
    :goto_2
    iget-object v2, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    monitor-enter v2

    .line 183
    :try_start_1
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    const/4 v3, 0x1

    # setter for: Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->mDone:Z
    invoke-static {v1, v3}, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->access$102(Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;Z)Z

    .line 184
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 185
    monitor-exit v2

    goto/16 :goto_0

    :catchall_1
    move-exception v1

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    throw v1

    .line 177
    :cond_1
    const-string v1, "SecurityManager"

    const-string v2, "handleMessage: Faile"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 178
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iput-object v3, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->response:Ljava/lang/Object;

    goto :goto_2

    .line 188
    .end local v0    # "ar":Landroid/os/AsyncResult;
    :sswitch_2
    const-string v1, "SecurityManager"

    const-string v2, "handleMessage : SECURITY_PROCESS_COMMAND_PERSONALIZATION"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 189
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 190
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v1, :cond_2

    iget-object v1, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v1, :cond_2

    .line 191
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iget-object v2, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    iput-object v2, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->response:Ljava/lang/Object;

    .line 192
    const-string v1, "SecurityManager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "handleMessage : SECURITY_PROCESS_COMMAND_PERSONALIZATION("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    iget-object v3, v3, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iget-object v3, v3, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->response:Ljava/lang/Object;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 198
    :goto_3
    iget-object v2, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    monitor-enter v2

    .line 200
    :try_start_2
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    const/4 v3, 0x1

    # setter for: Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->mDone:Z
    invoke-static {v1, v3}, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->access$102(Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;Z)Z

    .line 201
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 202
    monitor-exit v2

    goto/16 :goto_0

    :catchall_2
    move-exception v1

    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    throw v1

    .line 194
    :cond_2
    const-string v1, "SecurityManager"

    const-string v2, "handleMessage: Faile"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 195
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iput-object v3, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->response:Ljava/lang/Object;

    goto :goto_3

    .line 206
    .end local v0    # "ar":Landroid/os/AsyncResult;
    :sswitch_3
    const-string v1, "SecurityManager"

    const-string v2, "handleMessage : SECURITY_PROCESS_COMMAND_DEBUG_ENABLE"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 207
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 208
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v1, :cond_3

    iget-object v1, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v1, :cond_3

    .line 209
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iget-object v2, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    iput-object v2, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->response:Ljava/lang/Object;

    .line 210
    const-string v1, "SecurityManager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "handleMessage : SECURITY_PROCESS_COMMAND_DEBUG_ENABLE("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    iget-object v3, v3, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iget-object v3, v3, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->response:Ljava/lang/Object;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 216
    :goto_4
    iget-object v2, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    monitor-enter v2

    .line 218
    :try_start_3
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    const/4 v3, 0x1

    # setter for: Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->mDone:Z
    invoke-static {v1, v3}, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->access$102(Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;Z)Z

    .line 219
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 220
    monitor-exit v2

    goto/16 :goto_0

    :catchall_3
    move-exception v1

    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    throw v1

    .line 212
    :cond_3
    const-string v1, "SecurityManager"

    const-string v2, " handleMessage: Faile"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 213
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$1;->this$0:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->data:Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;

    iput-object v3, v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread$SecurityIO;->response:Ljava/lang/Object;

    goto :goto_4

    .line 153
    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x2 -> :sswitch_1
        0x3 -> :sswitch_2
        0xe -> :sswitch_3
    .end sparse-switch
.end method
