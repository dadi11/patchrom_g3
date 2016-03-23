.class Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;
.super Ljava/lang/Object;
.source "InboundSmsHandlerEx.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/InboundSmsHandlerEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "IncompleteConcatDispatchTimer"
.end annotation


# instance fields
.field concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

.field private expireTimerValue:J

.field private inCompeteConcatFirstTime:J

.field final synthetic this$0:Lcom/android/internal/telephony/InboundSmsHandlerEx;


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/InboundSmsHandlerEx;Lcom/android/internal/telephony/InboundSmsTracker;JJ)V
    .locals 1
    .param p2, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p3, "firstTime"    # J
    .param p5, "timerValue"    # J

    .prologue
    .line 2089
    iput-object p1, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->this$0:Lcom/android/internal/telephony/InboundSmsHandlerEx;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2090
    iput-wide p3, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->inCompeteConcatFirstTime:J

    .line 2091
    iput-wide p5, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->expireTimerValue:J

    .line 2092
    iput-object p2, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    .line 2093
    return-void
.end method

.method private dispatchIncompletedConcat()V
    .locals 28

    .prologue
    .line 2105
    const/4 v14, 0x0

    .line 2106
    .local v14, "cursor":Landroid/database/Cursor;
    const/4 v2, 0x2

    new-array v6, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {v3}, Lcom/android/internal/telephony/InboundSmsTracker;->getReferenceNumber()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v6, v2

    const/4 v2, 0x1

    move-object/from16 v0, p0

    iget-wide v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->inCompeteConcatFirstTime:J

    invoke-static {v4, v5}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v6, v2

    .line 2107
    .local v6, "whereArgs":[Ljava/lang/String;
    const/16 v24, 0x0

    check-cast v24, [[B

    .line 2108
    .local v24, "pdus":[[B
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dispatchIncompletedConcat, [RED] concatTracker.getReferenceNumber()= "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {v3}, Lcom/android/internal/telephony/InboundSmsTracker;->getReferenceNumber()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 2109
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dispatchIncompletedConcat, [RED] inCompeteConcatFirstTime= "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, p0

    iget-wide v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->inCompeteConcatFirstTime:J

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 2110
    new-instance v22, Ljava/lang/String;

    invoke-direct/range {v22 .. v22}, Ljava/lang/String;-><init>()V

    .line 2111
    .local v22, "missingSegIndex":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {v2}, Lcom/android/internal/telephony/InboundSmsTracker;->getDestPort()I

    move-result v18

    .line 2112
    .local v18, "destPort":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dispatchIncompletedConcat,  concatTracker.getDestPort()= "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {v3}, Lcom/android/internal/telephony/InboundSmsTracker;->getDestPort()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 2114
    :try_start_0
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->this$0:Lcom/android/internal/telephony/InboundSmsHandlerEx;

    iget-object v2, v2, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v3, Lcom/android/internal/telephony/InboundSmsHandler;->sRawUri:Landroid/net/Uri;

    # getter for: Lcom/android/internal/telephony/InboundSmsHandlerEx;->PDU_SEQUENCE_PORT_ICC_TIME_PROJECTION:[Ljava/lang/String;
    invoke-static {}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->access$000()[Ljava/lang/String;

    move-result-object v4

    const-string v5, "reference_number=? AND time=?"

    const/4 v7, 0x0

    invoke-virtual/range {v2 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v14

    .line 2119
    if-eqz v14, :cond_e

    invoke-interface {v14}, Landroid/database/Cursor;->getCount()I

    move-result v2

    if-lez v2, :cond_e

    .line 2120
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->this$0:Lcom/android/internal/telephony/InboundSmsHandlerEx;

    iget-object v2, v2, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v3, "concat_expired_time"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 2121
    const/16 v17, 0x0

    .line 2122
    .local v17, "deletedCount":I
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->this$0:Lcom/android/internal/telephony/InboundSmsHandlerEx;

    iget-object v2, v2, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v3, Lcom/android/internal/telephony/InboundSmsHandler;->sRawUri:Landroid/net/Uri;

    const-string v4, "reference_number=? AND time=?"

    invoke-virtual {v2, v3, v4, v6}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v17

    .line 2123
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dispatchIncompletedConcat(), [RED] CMCC LMS Expiry Timeout! deletedCount = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, v17

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/database/SQLException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2217
    if-eqz v14, :cond_0

    .line 2218
    invoke-interface {v14}, Landroid/database/Cursor;->close()V

    .line 2221
    .end local v17    # "deletedCount":I
    :cond_0
    :goto_0
    return-void

    .line 2126
    :cond_1
    :try_start_1
    invoke-interface {v14}, Landroid/database/Cursor;->getCount()I

    move-result v15

    .line 2127
    .local v15, "cursorCount":I
    const-string v2, "pdu"

    invoke-interface {v14, v2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v23

    .line 2128
    .local v23, "pduColumn":I
    const-string v2, "sequence"

    invoke-interface {v14, v2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v26

    .line 2129
    .local v26, "sequenceColumn":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dispatchIncompletedConcat, [RED] cursorCount= "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 2130
    const/16 v27, 0x0

    .line 2132
    .local v27, "stitchRefMsg":Landroid/telephony/SmsMessage;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {v2}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v2

    new-array v0, v2, [[B

    move-object/from16 v24, v0

    .line 2134
    :cond_2
    :goto_1
    invoke-interface {v14}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_4

    .line 2135
    move/from16 v0, v26

    invoke-interface {v14, v0}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v2

    long-to-int v0, v2

    move/from16 v16, v0

    .line 2136
    .local v16, "cursorSequence":I
    add-int/lit8 v2, v16, -0x1

    move/from16 v0, v23

    invoke-interface {v14, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/util/HexDump;->hexStringToByteArray(Ljava/lang/String;)[B

    move-result-object v3

    aput-object v3, v24, v2

    .line 2137
    if-nez v27, :cond_3

    .line 2138
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dispatchIncompletedConcat, [RED] createFromPdu for stitchRefMsg index = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, v16

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2139
    add-int/lit8 v2, v16, -0x1

    aget-object v2, v24, v2

    invoke-static {v2}, Landroid/telephony/SmsMessage;->createFromPdu([B)Landroid/telephony/SmsMessage;

    move-result-object v27

    .line 2143
    :cond_3
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {v2}, Lcom/android/internal/telephony/InboundSmsTracker;->getIndexOffset()I

    move-result v2

    sub-int v21, v16, v2

    .line 2144
    .local v21, "index":I
    const-string v2, "dispatchIncompletedConcat(), check wap push , Destination port"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2147
    if-nez v21, :cond_2

    const/4 v2, 0x2

    invoke-interface {v14, v2}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_2

    .line 2148
    const/4 v2, 0x2

    invoke-interface {v14, v2}, Landroid/database/Cursor;->getInt(I)I

    move-result v25

    .line 2150
    .local v25, "port":I
    invoke-static/range {v25 .. v25}, Lcom/android/internal/telephony/InboundSmsTracker;->getRealDestPort(I)I

    move-result v25

    .line 2151
    const/4 v2, -0x1

    move/from16 v0, v25

    if-eq v0, v2, :cond_2

    .line 2152
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dispatchIncompletedConcat(),destport = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, v18

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", getRealDestPort: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, v25

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2153
    move/from16 v18, v25

    goto/16 :goto_1

    .line 2158
    .end local v16    # "cursorSequence":I
    .end local v21    # "index":I
    .end local v25    # "port":I
    :cond_4
    const/16 v20, 0x0

    .local v20, "i":I
    :goto_2
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {v2}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v2

    move/from16 v0, v20

    if-ge v0, v2, :cond_7

    .line 2159
    aget-object v2, v24, v20

    if-eqz v2, :cond_6

    aget-object v2, v24, v20

    array-length v2, v2

    if-lez v2, :cond_6

    .line 2161
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dispatchIncompletedConcat, [RED] fill pdu seg= "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, v20

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 2158
    :cond_5
    :goto_3
    add-int/lit8 v20, v20, 0x1

    goto :goto_2

    .line 2163
    :cond_6
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dispatchIncompletedConcat, [RED] fill missing seg= "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, v20

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 2164
    invoke-static/range {v20 .. v20}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    move-object/from16 v0, v22

    invoke-virtual {v0, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v22

    .line 2165
    const-string v2, ","

    move-object/from16 v0, v22

    invoke-virtual {v0, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v22

    .line 2166
    if-eqz v27, :cond_5

    .line 2167
    invoke-virtual/range {v27 .. v27}, Landroid/telephony/SmsMessage;->getPdu()[B

    move-result-object v2

    aput-object v2, v24, v20

    .line 2168
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dispatchIncompletedConcat, pdus["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, v20

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "] = stitchRefMsg.getPdu()"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/database/SQLException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_3

    .line 2210
    .end local v15    # "cursorCount":I
    .end local v20    # "i":I
    .end local v23    # "pduColumn":I
    .end local v26    # "sequenceColumn":I
    .end local v27    # "stitchRefMsg":Landroid/telephony/SmsMessage;
    :catch_0
    move-exception v19

    .line 2211
    .local v19, "e":Landroid/database/SQLException;
    :try_start_2
    const-string v2, "dispatchIncompletedConcat(), query exception catch"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 2217
    if-eqz v14, :cond_0

    .line 2218
    invoke-interface {v14}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 2172
    .end local v19    # "e":Landroid/database/SQLException;
    .restart local v15    # "cursorCount":I
    .restart local v20    # "i":I
    .restart local v23    # "pduColumn":I
    .restart local v26    # "sequenceColumn":I
    .restart local v27    # "stitchRefMsg":Landroid/telephony/SmsMessage;
    :cond_7
    :try_start_3
    new-instance v11, Lcom/android/internal/telephony/InboundSmsHandler$SmsBroadcastReceiver;

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->this$0:Lcom/android/internal/telephony/InboundSmsHandlerEx;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-direct {v11, v2, v3}, Lcom/android/internal/telephony/InboundSmsHandler$SmsBroadcastReceiver;-><init>(Lcom/android/internal/telephony/InboundSmsHandler;Lcom/android/internal/telephony/InboundSmsTracker;)V

    .line 2173
    .local v11, "resultReceiver":Landroid/content/BroadcastReceiver;
    new-instance v8, Landroid/content/Intent;

    const-string v2, "android.provider.Telephony.SMS_DELIVER"

    invoke-direct {v8, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 2174
    .local v8, "intent":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->this$0:Lcom/android/internal/telephony/InboundSmsHandlerEx;

    iget-object v2, v2, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const/4 v3, 0x1

    invoke-static {v2, v3}, Lcom/android/internal/telephony/SmsApplication;->getDefaultSmsApplication(Landroid/content/Context;Z)Landroid/content/ComponentName;

    move-result-object v13

    .line 2175
    .local v13, "componentName":Landroid/content/ComponentName;
    if-eqz v13, :cond_8

    .line 2176
    invoke-virtual {v8, v13}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 2177
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->this$0:Lcom/android/internal/telephony/InboundSmsHandlerEx;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Delivering SMS to: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v13}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v13}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 2180
    :cond_8
    const-string v2, "pdus"

    move-object/from16 v0, v24

    invoke-virtual {v8, v2, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 2181
    const-string v2, "format"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {v3}, Lcom/android/internal/telephony/InboundSmsTracker;->getFormat()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v8, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 2182
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->this$0:Lcom/android/internal/telephony/InboundSmsHandlerEx;

    iget-object v2, v2, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v3, "seperate_processing_sms_uicc"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_9

    .line 2183
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {v2}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_b

    .line 2184
    const-string v2, "indexOnIcc"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {v3}, Lcom/android/internal/telephony/InboundSmsTracker;->lgeGetIndexOnIcc()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v8, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 2189
    :cond_9
    :goto_4
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {v2}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v2

    const/4 v3, 0x1

    if-le v2, v3, :cond_c

    .line 2190
    const-string v2, "ctreplace"

    const/4 v3, 0x1

    invoke-virtual {v8, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 2191
    if-eqz v22, :cond_a

    .line 2192
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dispatchIncompletedConcat(), [RED] missingSegIndex = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, v22

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2193
    const-string v2, "missingSegIndex"

    move-object/from16 v0, v22

    invoke-virtual {v8, v2, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 2195
    :cond_a
    const-string v2, "refNumber"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {v3}, Lcom/android/internal/telephony/InboundSmsTracker;->getReferenceNumber()I

    move-result v3

    invoke-virtual {v8, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 2199
    :goto_5
    const/16 v2, 0xb84

    move/from16 v0, v18

    if-ne v0, v2, :cond_d

    .line 2200
    const-string v2, "dispatchIncompletedConcat(),this is wap push message!"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_3
    .catch Landroid/database/SQLException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 2217
    if-eqz v14, :cond_0

    .line 2218
    invoke-interface {v14}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 2186
    :cond_b
    :try_start_4
    const-string v2, "indexOnIcc"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    iget-object v3, v3, Lcom/android/internal/telephony/InboundSmsTracker;->iccIndexSring:Ljava/lang/String;

    invoke-virtual {v8, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    :try_end_4
    .catch Landroid/database/SQLException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_4

    .line 2212
    .end local v8    # "intent":Landroid/content/Intent;
    .end local v11    # "resultReceiver":Landroid/content/BroadcastReceiver;
    .end local v13    # "componentName":Landroid/content/ComponentName;
    .end local v15    # "cursorCount":I
    .end local v20    # "i":I
    .end local v23    # "pduColumn":I
    .end local v26    # "sequenceColumn":I
    .end local v27    # "stitchRefMsg":Landroid/telephony/SmsMessage;
    :catch_1
    move-exception v19

    .line 2213
    .local v19, "e":Ljava/lang/IllegalArgumentException;
    :try_start_5
    const-string v2, "dispatchIncompletedConcat(), query IllegalArgumentException catch"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 2217
    if-eqz v14, :cond_0

    .line 2218
    invoke-interface {v14}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 2197
    .end local v19    # "e":Ljava/lang/IllegalArgumentException;
    .restart local v8    # "intent":Landroid/content/Intent;
    .restart local v11    # "resultReceiver":Landroid/content/BroadcastReceiver;
    .restart local v13    # "componentName":Landroid/content/ComponentName;
    .restart local v15    # "cursorCount":I
    .restart local v20    # "i":I
    .restart local v23    # "pduColumn":I
    .restart local v26    # "sequenceColumn":I
    .restart local v27    # "stitchRefMsg":Landroid/telephony/SmsMessage;
    :cond_c
    :try_start_6
    const-string v2, "ctreplace"

    const/4 v3, 0x0

    invoke-virtual {v8, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;
    :try_end_6
    .catch Landroid/database/SQLException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_6 .. :try_end_6} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_6 .. :try_end_6} :catch_2
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto :goto_5

    .line 2214
    .end local v8    # "intent":Landroid/content/Intent;
    .end local v11    # "resultReceiver":Landroid/content/BroadcastReceiver;
    .end local v13    # "componentName":Landroid/content/ComponentName;
    .end local v15    # "cursorCount":I
    .end local v20    # "i":I
    .end local v23    # "pduColumn":I
    .end local v26    # "sequenceColumn":I
    .end local v27    # "stitchRefMsg":Landroid/telephony/SmsMessage;
    :catch_2
    move-exception v19

    .line 2215
    .local v19, "e":Ljava/lang/NullPointerException;
    :try_start_7
    const-string v2, "dispatchIncompletedConcat(), null pointer exception catch"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 2217
    if-eqz v14, :cond_0

    .line 2218
    invoke-interface {v14}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 2203
    .end local v19    # "e":Ljava/lang/NullPointerException;
    .restart local v8    # "intent":Landroid/content/Intent;
    .restart local v11    # "resultReceiver":Landroid/content/BroadcastReceiver;
    .restart local v13    # "componentName":Landroid/content/ComponentName;
    .restart local v15    # "cursorCount":I
    .restart local v20    # "i":I
    .restart local v23    # "pduColumn":I
    .restart local v26    # "sequenceColumn":I
    .restart local v27    # "stitchRefMsg":Landroid/telephony/SmsMessage;
    :cond_d
    :try_start_8
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->concatTracker:Lcom/android/internal/telephony/InboundSmsTracker;

    const/4 v3, 0x1

    iput-boolean v3, v2, Lcom/android/internal/telephony/InboundSmsTracker;->isExpiredByTimer:Z

    .line 2204
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->this$0:Lcom/android/internal/telephony/InboundSmsHandlerEx;

    const-string v9, "android.permission.RECEIVE_SMS"

    const/16 v10, 0x10

    sget-object v12, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    invoke-virtual/range {v7 .. v12}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V
    :try_end_8
    .catch Landroid/database/SQLException; {:try_start_8 .. :try_end_8} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_8 .. :try_end_8} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_8 .. :try_end_8} :catch_2
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 2217
    .end local v8    # "intent":Landroid/content/Intent;
    .end local v11    # "resultReceiver":Landroid/content/BroadcastReceiver;
    .end local v13    # "componentName":Landroid/content/ComponentName;
    .end local v15    # "cursorCount":I
    .end local v20    # "i":I
    .end local v23    # "pduColumn":I
    .end local v26    # "sequenceColumn":I
    .end local v27    # "stitchRefMsg":Landroid/telephony/SmsMessage;
    :goto_6
    if-eqz v14, :cond_0

    .line 2218
    invoke-interface {v14}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 2207
    :cond_e
    :try_start_9
    const-string v2, "dispatchIncompletedConcat(), cursorCount is null"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_9
    .catch Landroid/database/SQLException; {:try_start_9 .. :try_end_9} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_9 .. :try_end_9} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_9 .. :try_end_9} :catch_2
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    goto :goto_6

    .line 2217
    :catchall_0
    move-exception v2

    if-eqz v14, :cond_f

    .line 2218
    invoke-interface {v14}, Landroid/database/Cursor;->close()V

    :cond_f
    throw v2
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 2097
    :try_start_0
    iget-wide v2, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->expireTimerValue:J

    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2101
    :goto_0
    invoke-direct {p0}, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;->dispatchIncompletedConcat()V

    .line 2102
    return-void

    .line 2098
    :catch_0
    move-exception v0

    .line 2099
    .local v0, "e":Ljava/lang/InterruptedException;
    const-string v1, "IncompleteConcatDispatchTimer:run(), Thread Interrupted exception catch"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method
