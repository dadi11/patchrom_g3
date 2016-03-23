.class public Lcom/android/internal/telephony/RIL$LgeRIL;
.super Ljava/lang/Object;
.source "RIL.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/RIL;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "LgeRIL"
.end annotation


# instance fields
.field final DBG:Z

.field final LOG_TAG:Ljava/lang/String;

.field mRil:Lcom/android/internal/telephony/RIL;

.field final synthetic this$0:Lcom/android/internal/telephony/RIL;


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/RIL;Lcom/android/internal/telephony/RIL;)V
    .locals 2
    .param p2, "ril"    # Lcom/android/internal/telephony/RIL;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "RILJLge"

    iput-object v0, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->LOG_TAG:Ljava/lang/String;

    const-string v0, "ro.debuggable"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "1"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->DBG:Z

    iput-object p2, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->mRil:Lcom/android/internal/telephony/RIL;

    return-void
.end method

.method private dLogD(Ljava/lang/String;)V
    .locals 3
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    iget-boolean v0, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->DBG:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    const-string v0, "LGSmartcard"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[RILJLge] "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method


# virtual methods
.method protected enableSmartcardLog(Lcom/android/internal/telephony/RILRequest;)Z
    .locals 3
    .param p1, "rr"    # Lcom/android/internal/telephony/RILRequest;

    .prologue
    const/4 v0, 0x1

    iget v1, p1, Lcom/android/internal/telephony/RILRequest;->mRequest:I

    const/16 v2, 0x15f

    if-lt v1, v2, :cond_0

    iget v1, p1, Lcom/android/internal/telephony/RILRequest;->mRequest:I

    const/16 v2, 0x163

    if-le v1, v2, :cond_3

    :cond_0
    iget v1, p1, Lcom/android/internal/telephony/RILRequest;->mRequest:I

    const/16 v2, 0x72

    if-lt v1, v2, :cond_1

    iget v1, p1, Lcom/android/internal/telephony/RILRequest;->mRequest:I

    const/16 v2, 0x75

    if-le v1, v2, :cond_3

    :cond_1
    iget v1, p1, Lcom/android/internal/telephony/RILRequest;->mRequest:I

    const/16 v2, 0x83

    if-eq v1, v2, :cond_3

    :cond_2
    :goto_0
    return v0

    :cond_3
    iget-boolean v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->DBG:Z

    if-nez v1, :cond_2

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public iccCloseChannel(ILandroid/os/Message;)V
    .locals 3
    .param p1, "channel"    # I
    .param p2, "result"    # Landroid/os/Message;

    .prologue
    const/16 v1, 0x161

    invoke-static {v1, p2}, Lcom/android/internal/telephony/RILRequest;->obtain(ILandroid/os/Message;)Lcom/android/internal/telephony/RILRequest;

    move-result-object v0

    .local v0, "rr":Lcom/android/internal/telephony/RILRequest;
    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeInt(I)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Lcom/android/internal/telephony/RILRequest;->serialString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "> iccCloseChannel: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, v0, Lcom/android/internal/telephony/RILRequest;->mRequest:I

    invoke-static {v2}, Lcom/android/internal/telephony/RIL;->requestToString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/RIL$LgeRIL;->dLogD(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, v0}, Lcom/android/internal/telephony/RIL;->send(Lcom/android/internal/telephony/RILRequest;)V

    return-void
.end method

.method public iccExchangeAPDU(IIIIIILjava/lang/String;Landroid/os/Message;)V
    .locals 3
    .param p1, "cla"    # I
    .param p2, "command"    # I
    .param p3, "channel"    # I
    .param p4, "p1"    # I
    .param p5, "p2"    # I
    .param p6, "p3"    # I
    .param p7, "data"    # Ljava/lang/String;
    .param p8, "result"    # Landroid/os/Message;

    .prologue
    const/4 v2, 0x0

    if-nez p3, :cond_1

    const/16 v1, 0x15f

    invoke-static {v1, p8}, Lcom/android/internal/telephony/RILRequest;->obtain(ILandroid/os/Message;)Lcom/android/internal/telephony/RILRequest;

    move-result-object v0

    .local v0, "rr":Lcom/android/internal/telephony/RILRequest;
    :goto_0
    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v1, p3}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v1, v2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v1, p4}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v1, p5}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v1, p6}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v1, p7}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v1, v2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-boolean v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->DBG:Z

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Lcom/android/internal/telephony/RILRequest;->serialString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "> iccExchangeAPDU: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, v0, Lcom/android/internal/telephony/RILRequest;->mRequest:I

    invoke-static {v2}, Lcom/android/internal/telephony/RIL;->requestToString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " 0x"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " 0x"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p2}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " 0x"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p3}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/RIL$LgeRIL;->dLogD(Ljava/lang/String;)V

    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, v0}, Lcom/android/internal/telephony/RIL;->send(Lcom/android/internal/telephony/RILRequest;)V

    return-void

    .end local v0    # "rr":Lcom/android/internal/telephony/RILRequest;
    :cond_1
    const/16 v1, 0x162

    invoke-static {v1, p8}, Lcom/android/internal/telephony/RILRequest;->obtain(ILandroid/os/Message;)Lcom/android/internal/telephony/RILRequest;

    move-result-object v0

    .restart local v0    # "rr":Lcom/android/internal/telephony/RILRequest;
    goto/16 :goto_0
.end method

.method public iccGetATR(Landroid/os/Message;)V
    .locals 3
    .param p1, "result"    # Landroid/os/Message;

    .prologue
    const/16 v1, 0x163

    invoke-static {v1, p1}, Lcom/android/internal/telephony/RILRequest;->obtain(ILandroid/os/Message;)Lcom/android/internal/telephony/RILRequest;

    move-result-object v0

    .local v0, "rr":Lcom/android/internal/telephony/RILRequest;
    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/os/Parcel;->writeInt(I)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Lcom/android/internal/telephony/RILRequest;->serialString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "> iccGetATR: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, v0, Lcom/android/internal/telephony/RILRequest;->mRequest:I

    invoke-static {v2}, Lcom/android/internal/telephony/RIL;->requestToString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/RIL$LgeRIL;->dLogD(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, v0}, Lcom/android/internal/telephony/RIL;->send(Lcom/android/internal/telephony/RILRequest;)V

    return-void
.end method

.method public iccOpenChannel(Ljava/lang/String;Landroid/os/Message;)V
    .locals 3
    .param p1, "AID"    # Ljava/lang/String;
    .param p2, "result"    # Landroid/os/Message;

    .prologue
    const/16 v1, 0x160

    invoke-static {v1, p2}, Lcom/android/internal/telephony/RILRequest;->obtain(ILandroid/os/Message;)Lcom/android/internal/telephony/RILRequest;

    move-result-object v0

    .local v0, "rr":Lcom/android/internal/telephony/RILRequest;
    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Lcom/android/internal/telephony/RILRequest;->serialString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "> iccOpenChannel: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, v0, Lcom/android/internal/telephony/RILRequest;->mRequest:I

    invoke-static {v2}, Lcom/android/internal/telephony/RIL;->requestToString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/RIL$LgeRIL;->dLogD(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, v0}, Lcom/android/internal/telephony/RIL;->send(Lcom/android/internal/telephony/RILRequest;)V

    return-void
.end method

.method protected processRegistrantsUnsolicitedForOEM(ILjava/lang/Object;)V
    .locals 18
    .param p1, "requestCommand"    # I
    .param p2, "responseReadMessage"    # Ljava/lang/Object;

    .prologue
    sparse-switch p1, :sswitch_data_0

    .end local p2    # "responseReadMessage":Ljava/lang/Object;
    :cond_0
    :goto_0
    return-void

    .restart local p2    # "responseReadMessage":Ljava/lang/Object;
    :sswitch_0
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    const-string v14, "[Periodic CSG] setCSGSelectionManual in RIL.java :  "

    # invokes: Lcom/android/internal/telephony/RIL;->riljLog(Ljava/lang/String;)V
    invoke-static {v13, v14}, Lcom/android/internal/telephony/RIL;->access$3200(Lcom/android/internal/telephony/RIL;Ljava/lang/String;)V

    const/16 v13, 0xff

    const/4 v14, 0x0

    invoke-static {v13, v14}, Lcom/android/internal/telephony/RILRequest;->obtain(ILandroid/os/Message;)Lcom/android/internal/telephony/RILRequest;

    move-result-object v12

    .local v12, "rr":Lcom/android/internal/telephony/RILRequest;
    iget-object v13, v12, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    const/4 v14, 0x1

    invoke-virtual {v13, v14}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v13, v12, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    const/4 v14, 0x1

    invoke-virtual {v13, v14}, Landroid/os/Parcel;->writeInt(I)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12}, Lcom/android/internal/telephony/RILRequest;->serialString()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, "> "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    iget v15, v12, Lcom/android/internal/telephony/RILRequest;->mRequest:I

    invoke-static {v15}, Lcom/android/internal/telephony/RIL;->requestToString(I)Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    # invokes: Lcom/android/internal/telephony/RIL;->riljLog(Ljava/lang/String;)V
    invoke-static {v13, v14}, Lcom/android/internal/telephony/RIL;->access$3200(Lcom/android/internal/telephony/RIL;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v13, v12}, Lcom/android/internal/telephony/RIL;->send(Lcom/android/internal/telephony/RILRequest;)V

    goto :goto_0

    .end local v12    # "rr":Lcom/android/internal/telephony/RILRequest;
    :sswitch_1
    const/4 v13, 0x0

    const-string v14, "speech_codec_ind"

    invoke-static {v13, v14}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v13

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    check-cast p2, [I

    .end local p2    # "responseReadMessage":Ljava/lang/Object;
    move-object/from16 v3, p2

    check-cast v3, [I

    .local v3, "codec":[I
    if-eqz v3, :cond_0

    new-instance v4, Landroid/content/Intent;

    const-string v13, "com.lge.intent.action.VOICE_CODEC_INDICATOR"

    invoke-direct {v4, v13}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v4, "intent":Landroid/content/Intent;
    const-string v13, "speech_codec"

    const/4 v14, 0x0

    aget v14, v3, v14

    invoke-virtual {v4, v13, v14}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mContext:Landroid/content/Context;

    sget-object v14, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v13, v4, v14}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    # getter for: Lcom/android/internal/telephony/RIL;->iec:Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;
    invoke-static {}, Lcom/android/internal/telephony/RIL;->access$3300()Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;

    move-result-object v13

    invoke-virtual {v13}, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->isIncomingExtendedCallstate()Z

    move-result v13

    if-eqz v13, :cond_0

    const/4 v13, 0x1

    const/4 v14, 0x0

    aget v14, v3, v14

    if-ne v13, v14, :cond_1

    # getter for: Lcom/android/internal/telephony/RIL;->iec:Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;
    invoke-static {}, Lcom/android/internal/telephony/RIL;->access$3300()Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;

    move-result-object v13

    const/4 v14, 0x1

    iput-boolean v14, v13, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->isHDVoice:Z

    :goto_1
    const-string v13, "IncomingExtendedCallstate"

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "HDVoice: "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    # getter for: Lcom/android/internal/telephony/RIL;->iec:Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;
    invoke-static {}, Lcom/android/internal/telephony/RIL;->access$3300()Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;

    move-result-object v15

    iget-boolean v15, v15, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->isHDVoice:Z

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->broadcastIncomingExtendedCallstate()V
    invoke-static {v13}, Lcom/android/internal/telephony/RIL;->access$3400(Lcom/android/internal/telephony/RIL;)V

    goto/16 :goto_0

    :cond_1
    # getter for: Lcom/android/internal/telephony/RIL;->iec:Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;
    invoke-static {}, Lcom/android/internal/telephony/RIL;->access$3300()Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;

    move-result-object v13

    const/4 v14, 0x0

    iput-boolean v14, v13, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->isHDVoice:Z

    goto :goto_1

    .end local v3    # "codec":[I
    .end local v4    # "intent":Landroid/content/Intent;
    .restart local p2    # "responseReadMessage":Ljava/lang/Object;
    :sswitch_2
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mOtaSessionSuccessRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mOtaSessionSuccessRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_3
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLog(I)V
    invoke-static {v13, v0}, Lcom/android/internal/telephony/RIL;->access$3500(Lcom/android/internal/telephony/RIL;I)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mOtaSessionFailRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mOtaSessionFailRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    const/16 v17, 0x0

    invoke-direct/range {v14 .. v17}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_4
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mCdmaSidChangedRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mCdmaSidChangedRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_5
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mWpbxStateChangedRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mWpbxStateChangedRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_6
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLog(I)V
    invoke-static {v13, v0}, Lcom/android/internal/telephony/RIL;->access$3500(Lcom/android/internal/telephony/RIL;I)V

    check-cast p2, [I

    .end local p2    # "responseReadMessage":Ljava/lang/Object;
    move-object/from16 v9, p2

    check-cast v9, [I

    .local v9, "lockInfo":[I
    if-eqz v9, :cond_3

    array-length v13, v9

    const/4 v14, 0x2

    if-ne v13, v14, :cond_2

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mLockStateRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mLockStateRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, v16

    invoke-direct {v14, v15, v9, v0}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :cond_2
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "CDMA_LOCK_INFO ERROR with wrong length "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    array-length v15, v9

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    # invokes: Lcom/android/internal/telephony/RIL;->riljLog(Ljava/lang/String;)V
    invoke-static {v13, v14}, Lcom/android/internal/telephony/RIL;->access$3200(Lcom/android/internal/telephony/RIL;Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_3
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    const-string v14, "CDMA_LOCK_INFO is NULL"

    # invokes: Lcom/android/internal/telephony/RIL;->riljLog(Ljava/lang/String;)V
    invoke-static {v13, v14}, Lcom/android/internal/telephony/RIL;->access$3200(Lcom/android/internal/telephony/RIL;Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v9    # "lockInfo":[I
    .restart local p2    # "responseReadMessage":Ljava/lang/Object;
    :sswitch_7
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLog(I)V
    invoke-static {v13, v0}, Lcom/android/internal/telephony/RIL;->access$3500(Lcom/android/internal/telephony/RIL;I)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mNetworkErrorDispRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mNetworkErrorDispRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_8
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mWcdmaRejectReceivedRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mWcdmaRejectReceivedRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_9
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mWcdmaAcceptReceivedRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mWcdmaAcceptReceivedRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_a
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mWcdmaNetChangedRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mWcdmaNetChangedRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_b
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mWcdmaNetToKoreaChangedRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mWcdmaNetToKoreaChangedRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_c
    const/4 v13, 0x0

    const-string v14, "LGU_KNIGHT_V2_9"

    invoke-static {v13, v14}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v13

    if-eqz v13, :cond_4

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    new-instance v7, Landroid/content/Intent;

    const-string v13, "com.lguplus.uknight.intent.receive.MEM_FULL"

    invoke-direct {v7, v13}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v7, "intent_mem_full":Landroid/content/Intent;
    const/16 v13, 0x20

    invoke-virtual {v7, v13}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mContext:Landroid/content/Context;

    invoke-virtual {v13, v7}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto/16 :goto_0

    .end local v7    # "intent_mem_full":Landroid/content/Intent;
    :cond_4
    const/4 v13, 0x0

    const-string v14, "SKT_DOD"

    invoke-static {v13, v14}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v13

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    new-instance v8, Landroid/content/Intent;

    const-string v13, "com.skt.smartagent.receive.MEM_FULL"

    invoke-direct {v8, v13}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v8, "intent_memory_full":Landroid/content/Intent;
    const/16 v13, 0x20

    invoke-virtual {v8, v13}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mContext:Landroid/content/Context;

    invoke-virtual {v13, v8}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto/16 :goto_0

    .end local v8    # "intent_memory_full":Landroid/content/Intent;
    :sswitch_d
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    new-instance v8, Landroid/content/Intent;

    const-string v13, "com.lge.moca.receive.MEM_FULL"

    invoke-direct {v8, v13}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .restart local v8    # "intent_memory_full":Landroid/content/Intent;
    const/16 v13, 0x20

    invoke-virtual {v8, v13}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mContext:Landroid/content/Context;

    invoke-virtual {v13, v8}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto/16 :goto_0

    .end local v8    # "intent_memory_full":Landroid/content/Intent;
    :sswitch_e
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mHdrLockRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mHdrLockRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_f
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mLteLockRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mLteLockRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_10
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mLteEmmRejectRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mLteEmmRejectRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_11
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v13, p2

    check-cast v13, [I

    check-cast v13, [I

    if-eqz v13, :cond_5

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "SPRINT LTE_EHRPD_FORCED : "

    invoke-virtual {v13, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    move-object/from16 v13, p2

    check-cast v13, [I

    check-cast v13, [I

    const/16 v16, 0x0

    aget v13, v13, v16

    invoke-virtual {v15, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/RIL;->riljLog(Ljava/lang/String;)V
    invoke-static {v14, v13}, Lcom/android/internal/telephony/RIL;->access$3200(Lcom/android/internal/telephony/RIL;Ljava/lang/String;)V

    :goto_2
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mLteEhrpdForcedChangedRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mLteEhrpdForcedChangedRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :cond_5
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    const-string v14, "(int[])responseReadMessage) is NULL"

    # invokes: Lcom/android/internal/telephony/RIL;->riljLog(Ljava/lang/String;)V
    invoke-static {v13, v14}, Lcom/android/internal/telephony/RIL;->access$3200(Lcom/android/internal/telephony/RIL;Ljava/lang/String;)V

    goto :goto_2

    :sswitch_12
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v13, p2

    check-cast v13, [I

    check-cast v13, [I

    if-eqz v13, :cond_6

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "SPRINT HDR_ROAM_INDICATOR : "

    invoke-virtual {v13, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    move-object/from16 v13, p2

    check-cast v13, [I

    check-cast v13, [I

    const/16 v16, 0x0

    aget v13, v13, v16

    invoke-virtual {v15, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/RIL;->riljLog(Ljava/lang/String;)V
    invoke-static {v14, v13}, Lcom/android/internal/telephony/RIL;->access$3200(Lcom/android/internal/telephony/RIL;Ljava/lang/String;)V

    :cond_6
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mHDRRoamingIndicatorRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mHDRRoamingIndicatorRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_13
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    check-cast p2, [I

    .end local p2    # "responseReadMessage":Ljava/lang/Object;
    move-object/from16 v10, p2

    check-cast v10, [I

    .local v10, "networkType":[I
    if-eqz v10, :cond_7

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "Broadcast(change) RIL_UNSOL_VOLTE_E911_NETWORK_TYPE intent - result = "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const/4 v15, 0x0

    aget v15, v10, v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    # invokes: Lcom/android/internal/telephony/RIL;->riljLog(Ljava/lang/String;)V
    invoke-static {v13, v14}, Lcom/android/internal/telephony/RIL;->access$3200(Lcom/android/internal/telephony/RIL;Ljava/lang/String;)V

    new-instance v6, Landroid/content/Intent;

    const-string v13, "com.lge.intent.action.VOLTE_E911_NETWORK_TYPE_COMPLETE"

    invoke-direct {v6, v13}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v6, "intent_i":Landroid/content/Intent;
    const-string v13, "result"

    const/4 v14, 0x0

    aget v14, v10, v14

    invoke-virtual {v6, v13, v14}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mContext:Landroid/content/Context;

    sget-object v14, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v13, v6, v14}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto/16 :goto_0

    .end local v6    # "intent_i":Landroid/content/Intent;
    :cond_7
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    const-string v14, "RIL_UNSOL_VOLTE_E911_NETWORK_TYPE is ERROR with wrong data"

    # invokes: Lcom/android/internal/telephony/RIL;->riljLog(Ljava/lang/String;)V
    invoke-static {v13, v14}, Lcom/android/internal/telephony/RIL;->access$3200(Lcom/android/internal/telephony/RIL;Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v10    # "networkType":[I
    .restart local p2    # "responseReadMessage":Ljava/lang/Object;
    :sswitch_14
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLog(I)V
    invoke-static {v13, v0}, Lcom/android/internal/telephony/RIL;->access$3500(Lcom/android/internal/telephony/RIL;I)V

    new-instance v5, Landroid/content/Intent;

    const-string v13, "com.lge.intent.action.ACTION_E911_STATE_READY_FOR_VOLTE"

    invoke-direct {v5, v13}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v5, "intentForVoLTE":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mContext:Landroid/content/Context;

    sget-object v14, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v13, v5, v14}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    const-string v14, "Broadcast VOLTE_E911_STATE_READY intent"

    # invokes: Lcom/android/internal/telephony/RIL;->riljLog(Ljava/lang/String;)V
    invoke-static {v13, v14}, Lcom/android/internal/telephony/RIL;->access$3200(Lcom/android/internal/telephony/RIL;Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v5    # "intentForVoLTE":Landroid/content/Intent;
    :sswitch_15
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v2, p2

    .local v2, "absTime":Ljava/lang/Object;
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mSIB16TimeRegistrant:Landroid/os/Registrant;

    if-eqz v13, :cond_8

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mSIB16TimeRegistrant:Landroid/os/Registrant;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, v16

    invoke-direct {v14, v15, v2, v0}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/Registrant;->notifyRegistrant(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :cond_8
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iput-object v2, v13, Lcom/android/internal/telephony/RIL;->mLastSIB16TimeInfo:Ljava/lang/Object;

    goto/16 :goto_0

    .end local v2    # "absTime":Ljava/lang/Object;
    :sswitch_16
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    const-string v13, "VZW"

    invoke-static {v13}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v13

    if-eqz v13, :cond_0

    move-object/from16 v13, p2

    check-cast v13, [I

    check-cast v13, [I

    if-eqz v13, :cond_0

    check-cast p2, [I

    .end local p2    # "responseReadMessage":Ljava/lang/Object;
    check-cast p2, [I

    const/4 v13, 0x0

    aget v13, p2, v13

    const/16 v14, 0x8

    if-ne v13, v14, :cond_0

    new-instance v4, Landroid/content/Intent;

    const-string v13, "com.lge.intent.COLD_SIM_DETECTED"

    invoke-direct {v4, v13}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .restart local v4    # "intent":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mContext:Landroid/content/Context;

    sget-object v14, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v13, v4, v14}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    const-string v14, "cold SIM detected"

    # invokes: Lcom/android/internal/telephony/RIL;->riljLog(Ljava/lang/String;)V
    invoke-static {v13, v14}, Lcom/android/internal/telephony/RIL;->access$3200(Lcom/android/internal/telephony/RIL;Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v4    # "intent":Landroid/content/Intent;
    .restart local p2    # "responseReadMessage":Ljava/lang/Object;
    :sswitch_17
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->lgeCipheringIndRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->lgeCipheringIndRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_18
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->lgeRacIndRegistrants:Landroid/os/RegistrantList;

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->lgeRacIndRegistrants:Landroid/os/RegistrantList;

    new-instance v14, Landroid/os/AsyncResult;

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v16

    invoke-direct {v14, v15, v0, v1}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v13, v14}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :sswitch_19
    const/4 v13, 0x0

    const-string v14, "SUPPORT_LOG_RF_INFO"

    invoke-static {v13, v14}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v13

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    move/from16 v0, p1

    move-object/from16 v1, p2

    # invokes: Lcom/android/internal/telephony/RIL;->unsljLogRet(ILjava/lang/Object;)V
    invoke-static {v13, v0, v1}, Lcom/android/internal/telephony/RIL;->access$3100(Lcom/android/internal/telephony/RIL;ILjava/lang/Object;)V

    check-cast p2, [I

    .end local p2    # "responseReadMessage":Ljava/lang/Object;
    move-object/from16 v11, p2

    check-cast v11, [I

    .local v11, "rfbandInfo":[I
    if-eqz v11, :cond_9

    new-instance v4, Landroid/content/Intent;

    const-string v13, "com.lge.intent.action.LOG_RF_BAND_INFO"

    invoke-direct {v4, v13}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .restart local v4    # "intent":Landroid/content/Intent;
    const/high16 v13, 0x20000000

    invoke-virtual {v4, v13}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    const-string v13, "interface"

    const/4 v14, 0x0

    aget v14, v11, v14

    invoke-virtual {v4, v13, v14}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v13, "band"

    const/4 v14, 0x1

    aget v14, v11, v14

    invoke-virtual {v4, v13, v14}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v13, "channel"

    const/4 v14, 0x2

    aget v14, v11, v14

    invoke-virtual {v4, v13, v14}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    iget-object v13, v13, Lcom/android/internal/telephony/RIL;->mContext:Landroid/content/Context;

    invoke-virtual {v13, v4}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto/16 :goto_0

    .end local v4    # "intent":Landroid/content/Intent;
    :cond_9
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    const-string v14, "RIL_UNSOL_LOG_RF_BAND_INFO is ERROR with wrong data"

    # invokes: Lcom/android/internal/telephony/RIL;->riljLog(Ljava/lang/String;)V
    invoke-static {v13, v14}, Lcom/android/internal/telephony/RIL;->access$3200(Lcom/android/internal/telephony/RIL;Ljava/lang/String;)V

    goto/16 :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x41b -> :sswitch_18
        0x478 -> :sswitch_2
        0x479 -> :sswitch_3
        0x47a -> :sswitch_4
        0x47b -> :sswitch_5
        0x47f -> :sswitch_11
        0x480 -> :sswitch_a
        0x481 -> :sswitch_b
        0x482 -> :sswitch_12
        0x484 -> :sswitch_c
        0x488 -> :sswitch_0
        0x489 -> :sswitch_17
        0x48d -> :sswitch_19
        0x491 -> :sswitch_d
        0x499 -> :sswitch_1
        0x49f -> :sswitch_13
        0x4a0 -> :sswitch_14
        0x4a3 -> :sswitch_16
        0x4a4 -> :sswitch_15
        0x4a8 -> :sswitch_6
        0x4a9 -> :sswitch_7
        0x4ab -> :sswitch_8
        0x4ac -> :sswitch_9
        0x4ad -> :sswitch_e
        0x4ae -> :sswitch_f
        0x4af -> :sswitch_10
    .end sparse-switch
.end method

.method public responseOpenLogicalChannel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 6
    .param p1, "p"    # Landroid/os/Parcel;

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    const/4 v2, 0x2

    new-array v0, v2, [Ljava/lang/String;

    .local v0, "response":[Ljava/lang/String;
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "temp":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v4

    invoke-virtual {p1}, Landroid/os/Parcel;->dataAvail()I

    move-result v2

    if-lez v2, :cond_0

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    :goto_0
    aput-object v2, v0, v5

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "responseOpenLogicalChannel::Type(1-int[])(2-int,String)::"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/RIL$LgeRIL;->dLogD(Ljava/lang/String;)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "responseOpenLogicalChannel::channel id::"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    aget-object v3, v0, v4

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/RIL$LgeRIL;->dLogD(Ljava/lang/String;)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "responseOpenLogicalChannel::response::"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    aget-object v3, v0, v5

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/RIL$LgeRIL;->dLogD(Ljava/lang/String;)V

    return-object v0

    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method

.method protected responseSolicitedForOEM(ILandroid/os/Parcel;)Ljava/lang/Object;
    .locals 4
    .param p1, "requestCommand"    # I
    .param p2, "p"    # Landroid/os/Parcel;

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    const/4 v0, 0x0

    .local v0, "ret":Ljava/lang/Object;
    sparse-switch p1, :sswitch_data_0

    new-instance v1, Ljava/lang/RuntimeException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unrecognized solicited response: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1

    :sswitch_0
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->mRil:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "ret":Ljava/lang/Object;
    :goto_0
    return-object v0

    .restart local v0    # "ret":Ljava/lang/Object;
    :sswitch_1
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->mRil:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseString(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1200(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_2
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->mRil:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseString(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1200(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_3
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_4
    invoke-virtual {p0, p2}, Lcom/android/internal/telephony/RIL$LgeRIL;->responseOpenLogicalChannel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_5
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseICC_IO(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1300(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_6
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseICC_IO(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1300(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_7
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseString(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1200(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_8
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_9
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->mRil:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_a
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_b
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_c
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_d
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_e
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_f
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseLogging(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1400(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_10
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseGetModemInfo(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1500(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_11
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_12
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_13
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_14
    const-string v1, "LGU_KNIGHT_V2_9"

    invoke-static {v2, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "SKT_DOD"

    invoke-static {v2, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseRaw(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1600(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :cond_1
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    .local v0, "ret":Ljava/lang/Integer;
    goto/16 :goto_0

    .local v0, "ret":Ljava/lang/Object;
    :sswitch_15
    const-string v1, "LGU_KNIGHT_V2_9"

    invoke-static {v2, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseKNGetData(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1700(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :cond_2
    const-string v1, "SKT_DOD"

    invoke-static {v2, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseOemSsaGetData(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1800(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :cond_3
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    .local v0, "ret":Ljava/lang/Integer;
    goto/16 :goto_0

    .local v0, "ret":Ljava/lang/Object;
    :sswitch_16
    const-string v1, "LGU_KNIGHT_V2_9"

    invoke-static {v2, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :cond_4
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    .local v0, "ret":Ljava/lang/Integer;
    goto/16 :goto_0

    .local v0, "ret":Ljava/lang/Object;
    :sswitch_17
    const-string v1, "SKT_DOD"

    invoke-static {v2, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseRaw(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1600(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :cond_5
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    .local v0, "ret":Ljava/lang/Integer;
    goto/16 :goto_0

    .local v0, "ret":Ljava/lang/Object;
    :sswitch_18
    const-string v1, "LGU_KNIGHT_V2_9"

    invoke-static {v2, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_6

    const-string v1, "SKT_DOD"

    invoke-static {v2, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_7

    :cond_6
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :cond_7
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    .local v0, "ret":Ljava/lang/Integer;
    goto/16 :goto_0

    .local v0, "ret":Ljava/lang/Object;
    :sswitch_19
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseRaw(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1600(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_1a
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseMocaGetData(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1900(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_1b
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseMocaGetRFParameter(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$2000(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_1c
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseMocaGetMisc(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$2100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_1d
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_1e
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseRaw(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1600(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_1f
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_20
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_21
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseString(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1200(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_22
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseString(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1200(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_23
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_24
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseAntennaConf(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$2200(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_25
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseAntennaInfo(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$2300(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_26
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_27
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_28
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_29
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseString(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1200(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_2a
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_2b
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_data_0
    .sparse-switch
        0xbf -> :sswitch_8
        0xe7 -> :sswitch_e
        0xe8 -> :sswitch_13
        0xe9 -> :sswitch_22
        0xfa -> :sswitch_2a
        0xfc -> :sswitch_0
        0xfd -> :sswitch_2b
        0xfe -> :sswitch_1
        0xff -> :sswitch_2
        0x115 -> :sswitch_a
        0x116 -> :sswitch_b
        0x117 -> :sswitch_c
        0x118 -> :sswitch_d
        0x154 -> :sswitch_20
        0x155 -> :sswitch_21
        0x15e -> :sswitch_12
        0x15f -> :sswitch_5
        0x160 -> :sswitch_4
        0x161 -> :sswitch_3
        0x162 -> :sswitch_6
        0x163 -> :sswitch_7
        0x16c -> :sswitch_24
        0x16d -> :sswitch_25
        0x171 -> :sswitch_23
        0x176 -> :sswitch_11
        0x177 -> :sswitch_10
        0x17d -> :sswitch_26
        0x180 -> :sswitch_9
        0x183 -> :sswitch_17
        0x184 -> :sswitch_14
        0x185 -> :sswitch_15
        0x186 -> :sswitch_16
        0x187 -> :sswitch_18
        0x191 -> :sswitch_f
        0x198 -> :sswitch_1b
        0x199 -> :sswitch_1c
        0x19a -> :sswitch_1e
        0x19b -> :sswitch_19
        0x19c -> :sswitch_1a
        0x19d -> :sswitch_1f
        0x19e -> :sswitch_1d
        0x1cb -> :sswitch_27
        0x1cc -> :sswitch_28
        0x4a6 -> :sswitch_29
    .end sparse-switch
.end method

.method protected responseUnsolicitedForOEM(ILandroid/os/Parcel;)Ljava/lang/Object;
    .locals 4
    .param p1, "requestCommand"    # I
    .param p2, "p"    # Landroid/os/Parcel;

    .prologue
    const/4 v2, 0x0

    const/4 v0, 0x0

    .local v0, "ret":Ljava/lang/Object;
    sparse-switch p1, :sswitch_data_0

    new-instance v1, Ljava/lang/RuntimeException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unrecognized unsol response: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1

    :sswitch_0
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseString(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1200(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "ret":Ljava/lang/Object;
    :goto_0
    return-object v0

    .restart local v0    # "ret":Ljava/lang/Object;
    :sswitch_1
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_2
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseSIB16(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$2400(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_3
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_4
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_5
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_6
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_7
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_8
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_9
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseUnSolLGEUnSol(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$2500(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_a
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_b
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_c
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_d
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :sswitch_e
    const-string v1, "LGU_KNIGHT_V2_9"

    invoke-static {v2, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseKNStateChg(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$2600(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :cond_0
    const-string v1, "SKT_DOD"

    invoke-static {v2, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseOemSsaStateChg(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$2700(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    .local v0, "ret":Ljava/lang/Integer;
    goto :goto_0

    .local v0, "ret":Ljava/lang/Object;
    :sswitch_f
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_10
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseMocaMiscNoti(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$2800(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_11
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseMocaAlarmEvent(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$2900(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_12
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_13
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_14
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_15
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_16
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_17
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseVoid(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$1100(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_18
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_19
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_1a
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_1b
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    # invokes: Lcom/android/internal/telephony/RIL;->responseUnsolDebugInfo(Landroid/os/Parcel;)Ljava/lang/Object;
    invoke-static {v1, p2}, Lcom/android/internal/telephony/RIL;->access$3000(Lcom/android/internal/telephony/RIL;Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_1c
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_1d
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_1e
    iget-object v1, p0, Lcom/android/internal/telephony/RIL$LgeRIL;->this$0:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_data_0
    .sparse-switch
        0x41b -> :sswitch_1d
        0x478 -> :sswitch_3
        0x479 -> :sswitch_4
        0x47a -> :sswitch_5
        0x47b -> :sswitch_6
        0x47f -> :sswitch_1a
        0x480 -> :sswitch_c
        0x481 -> :sswitch_d
        0x482 -> :sswitch_18
        0x483 -> :sswitch_e
        0x484 -> :sswitch_f
        0x485 -> :sswitch_1b
        0x488 -> :sswitch_0
        0x489 -> :sswitch_1c
        0x48d -> :sswitch_1e
        0x48f -> :sswitch_10
        0x490 -> :sswitch_11
        0x491 -> :sswitch_12
        0x499 -> :sswitch_1
        0x49f -> :sswitch_16
        0x4a0 -> :sswitch_17
        0x4a3 -> :sswitch_19
        0x4a4 -> :sswitch_2
        0x4a8 -> :sswitch_7
        0x4a9 -> :sswitch_8
        0x4aa -> :sswitch_9
        0x4ab -> :sswitch_a
        0x4ac -> :sswitch_b
        0x4ad -> :sswitch_13
        0x4ae -> :sswitch_14
        0x4af -> :sswitch_15
    .end sparse-switch
.end method
