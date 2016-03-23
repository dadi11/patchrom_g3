.class Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;
.super Lcom/android/internal/util/State;
.source "ePDGDualTypeConn.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/ePDGDualTypeConn;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DcNonetworkState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/server/ePDGDualTypeConn;


# direct methods
.method private constructor <init>(Lcom/android/server/ePDGDualTypeConn;)V
    .locals 0

    .prologue
    .line 1091
    iput-object p1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/server/ePDGDualTypeConn;Lcom/android/server/ePDGDualTypeConn$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p2, "x1"    # Lcom/android/server/ePDGDualTypeConn$1;

    .prologue
    .line 1091
    invoke-direct {p0, p1}, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;-><init>(Lcom/android/server/ePDGDualTypeConn;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 2

    .prologue
    .line 1096
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v0}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    .line 1097
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v0}, Lcom/android/server/ePDGDualTypeConn;->clearSettings()V

    .line 1100
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "DcNonetworkState state enter"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1102
    return-void
.end method

.method public exit()V
    .locals 2

    .prologue
    .line 1108
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "DcNonetworkState state exit"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1111
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 5
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v4, 0x1

    .line 1117
    iget v1, p1, Landroid/os/Message;->what:I

    sparse-switch v1, :sswitch_data_0

    .line 1221
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcNonetworkState nothandled msg.what=0x"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-static {v3}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1224
    const/4 v0, 0x0

    .line 1227
    .local v0, "retVal":Z
    :goto_0
    return v0

    .line 1123
    .end local v0    # "retVal":Z
    :sswitch_0
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcNonetworkState  : EVENT_SET_INIT_VALUE "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1124
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v2, v2, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mobileservicestate:I

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v4, v4, Lcom/android/server/ePDGDualTypeConn;->mobileRadioTech:I

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/server/ePDGDualTypeConn;->onNetworkupdate(ZII)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1126
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtReadyState:Lcom/android/server/ePDGDualTypeConn$DcReadyState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$1100(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcReadyState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$3100(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 1133
    :goto_1
    const/4 v0, 0x1

    .line 1134
    .restart local v0    # "retVal":Z
    goto :goto_0

    .line 1130
    .end local v0    # "retVal":Z
    :cond_0
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto :goto_1

    .line 1136
    :sswitch_1
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v2, v2, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    iget v3, p1, Landroid/os/Message;->arg1:I

    iget v4, p1, Landroid/os/Message;->arg2:I

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/server/ePDGDualTypeConn;->onNetworkupdate(ZII)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1138
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtReadyState:Lcom/android/server/ePDGDualTypeConn$DcReadyState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$1100(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcReadyState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$3200(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 1144
    :goto_2
    const/4 v0, 0x1

    .line 1146
    .restart local v0    # "retVal":Z
    goto :goto_0

    .line 1142
    .end local v0    # "retVal":Z
    :cond_1
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto :goto_2

    .line 1158
    :sswitch_2
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcNonetworkState  : EVENT_WIFI_CONNECT_DETAIL "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1159
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v4, v1, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    .line 1161
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v2, p1, Landroid/os/Message;->arg1:I

    iput v2, v1, Lcom/android/server/ePDGDualTypeConn;->wifiDetailedState:I

    .line 1162
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->checkwifidetailstatus()V

    .line 1164
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v2, v2, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mobileservicestate:I

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v4, v4, Lcom/android/server/ePDGDualTypeConn;->mobileRadioTech:I

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/server/ePDGDualTypeConn;->onNetworkupdate(ZII)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1166
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtReadyState:Lcom/android/server/ePDGDualTypeConn$DcReadyState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$1100(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcReadyState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$3300(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 1173
    :goto_3
    const/4 v0, 0x1

    .line 1174
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 1170
    .end local v0    # "retVal":Z
    :cond_2
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto :goto_3

    .line 1178
    :sswitch_3
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcNonetworkState  : EVENT_WFC_PREFER_CH "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1179
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v2, p1, Landroid/os/Message;->arg1:I

    iput v2, v1, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    .line 1180
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v2, v2, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mobileservicestate:I

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v4, v4, Lcom/android/server/ePDGDualTypeConn;->mobileRadioTech:I

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/server/ePDGDualTypeConn;->onNetworkupdate(ZII)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 1182
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtReadyState:Lcom/android/server/ePDGDualTypeConn$DcReadyState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$1100(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcReadyState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$3400(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 1188
    :goto_4
    const/4 v0, 0x1

    .line 1189
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 1186
    .end local v0    # "retVal":Z
    :cond_3
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto :goto_4

    .line 1192
    :sswitch_4
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcNonetworkState : EVENT_WFCSETTING_CH "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1194
    iget v1, p1, Landroid/os/Message;->arg1:I

    if-eq v1, v4, :cond_4

    .line 1195
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const/4 v2, 0x0

    iput-boolean v2, v1, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    .line 1199
    :goto_5
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v2, v2, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mobileservicestate:I

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v4, v4, Lcom/android/server/ePDGDualTypeConn;->mobileRadioTech:I

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/server/ePDGDualTypeConn;->onNetworkupdate(ZII)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 1201
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtReadyState:Lcom/android/server/ePDGDualTypeConn$DcReadyState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$1100(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcReadyState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$3500(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 1207
    :goto_6
    const/4 v0, 0x1

    .line 1208
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 1197
    .end local v0    # "retVal":Z
    :cond_4
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v4, v1, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    goto :goto_5

    .line 1205
    :cond_5
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto :goto_6

    .line 1211
    :sswitch_5
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcNonetworkState get request in no network so deffer msg"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1213
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v4, v1, Lcom/android/server/ePDGDualTypeConn;->isDCwaiting:Z

    .line 1215
    const/4 v0, 0x1

    .line 1216
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 1117
    :sswitch_data_0
    .sparse-switch
        0x40002 -> :sswitch_5
        0x40011 -> :sswitch_1
        0x40014 -> :sswitch_3
        0x40016 -> :sswitch_4
        0x40020 -> :sswitch_0
        0x40024 -> :sswitch_2
    .end sparse-switch
.end method
