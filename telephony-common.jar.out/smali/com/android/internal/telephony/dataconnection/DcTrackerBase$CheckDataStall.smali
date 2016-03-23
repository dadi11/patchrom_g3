.class public Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;
.super Landroid/os/AsyncTask;
.source "DcTrackerBase.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "CheckDataStall"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask",
        "<",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/dataconnection/DcTrackerBase;)V
    .locals 0

    .prologue
    .line 4110
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "x0"    # [Ljava/lang/Object;

    .prologue
    .line 4110
    check-cast p1, [Ljava/lang/Void;

    .end local p1    # "x0":[Ljava/lang/Object;
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->doInBackground([Ljava/lang/Void;)Ljava/lang/Void;

    move-result-object v0

    return-object v0
.end method

.method protected varargs doInBackground([Ljava/lang/Void;)Ljava/lang/Void;
    .locals 12
    .param p1, "params"    # [Ljava/lang/Void;

    .prologue
    .line 4114
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    .line 4116
    .local v6, "startTime":J
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const/4 v9, 0x1

    # setter for: Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mSendDataStallDNSQuery:Z
    invoke-static {v8, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->access$102(Lcom/android/internal/telephony/dataconnection/DcTrackerBase;Z)Z

    .line 4119
    :try_start_0
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const-string v9, "[antonio]we send DNS Query to outofcredit.myvzw.com"

    invoke-virtual {v8, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 4121
    const-string v8, "outofcredit.myvzw.com"

    invoke-static {v8}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v1

    .line 4124
    .local v1, "inetAddress":Ljava/net/InetAddress;
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "[antonio]we\'ve got CORRECT answer from outofcredit.myvzw.com : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 4125
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const-string v9, "[antonio]we don\'t run the Android\'s Data Recovery"

    invoke-virtual {v8, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 4126
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const-wide/16 v10, 0x0

    iput-wide v10, v8, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mSentSinceLastRecv:J

    .line 4127
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const/4 v9, 0x0

    iput v9, v8, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mNoRecvPollCount:I

    .line 4129
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const/4 v9, 0x0

    invoke-virtual {v8, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->putRecoveryAction(I)V
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0

    .line 4131
    const/4 v8, 0x0

    .line 4154
    .end local v1    # "inetAddress":Ljava/net/InetAddress;
    :goto_0
    return-object v8

    .line 4132
    :catch_0
    move-exception v0

    .line 4133
    .local v0, "e":Ljava/net/UnknownHostException;
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "[antonio]UnknownHostException for : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v0}, Ljava/net/UnknownHostException;->getMessage()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 4134
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 4135
    .local v4, "endTime":J
    sub-long v8, v4, v6

    const-wide/16 v10, 0x3e8

    div-long v2, v8, v10

    .line 4136
    .local v2, "elapseTime":J
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "[antonio]startTime : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " endTime : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " elapseTime : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 4137
    const-wide/16 v8, 0x1e

    cmp-long v8, v2, v8

    if-gez v8, :cond_0

    .line 4138
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const-string v9, "[antonio]we\'ve got wrong answer for outofcredit.myvzw.com in short time"

    invoke-virtual {v8, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 4139
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const-string v9, "[antonio]we don\'t run the Android\'s Data Recovery"

    invoke-virtual {v8, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 4140
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const-wide/16 v10, 0x0

    iput-wide v10, v8, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mSentSinceLastRecv:J

    .line 4141
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const/4 v9, 0x0

    iput v9, v8, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mNoRecvPollCount:I

    .line 4143
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const/4 v9, 0x0

    invoke-virtual {v8, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->putRecoveryAction(I)V

    .line 4145
    const/4 v8, 0x0

    goto :goto_0

    .line 4149
    :cond_0
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const-string v9, "[antonio]we\'ve got NO answer for outofcredit.myvzw.com"

    invoke-virtual {v8, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 4150
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const-string v9, "[antonio]we run the Android\'s Data Recovery"

    invoke-virtual {v8, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 4152
    iget-object v8, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$CheckDataStall;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const/4 v9, 0x3

    invoke-virtual {v8, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->putRecoveryAction(I)V

    .line 4154
    const/4 v8, 0x0

    goto/16 :goto_0
.end method
