.class public Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;
.super Ljava/lang/Object;
.source "SignalVZWToneUtil.java"


# static fields
.field public static final CDMA_INVALID_TONE:I = -0x1

.field public static final IS95_CONST_IR_ALERT_HIGH:I = 0x1

.field public static final IS95_CONST_IR_ALERT_LOW:I = 0x2

.field public static final IS95_CONST_IR_ALERT_MED:I = 0x0

.field public static final IS95_CONST_IR_SIGNAL_IS54B:I = 0x2

.field public static final IS95_CONST_IR_SIGNAL_ISDN:I = 0x1

.field public static final IS95_CONST_IR_SIGNAL_TONE:I = 0x0

.field public static final IS95_CONST_IR_SIGNAL_USR_DEFD_ALERT:I = 0x4

.field public static final IS95_CONST_IR_SIG_IS54B_L:I = 0x1

.field public static final IS95_CONST_IR_SIG_IS54B_NO_TONE:I = 0x0

.field public static final IS95_CONST_IR_SIG_IS54B_PBX_L:I = 0x7

.field public static final IS95_CONST_IR_SIG_IS54B_PBX_SLS:I = 0xa

.field public static final IS95_CONST_IR_SIG_IS54B_PBX_SS:I = 0x8

.field public static final IS95_CONST_IR_SIG_IS54B_PBX_SSL:I = 0x9

.field public static final IS95_CONST_IR_SIG_IS54B_PBX_S_X4:I = 0xb

.field public static final IS95_CONST_IR_SIG_IS54B_PPP:I = 0xc

.field public static final IS95_CONST_IR_SIG_IS54B_SLS:I = 0x5

.field public static final IS95_CONST_IR_SIG_IS54B_SS:I = 0x2

.field public static final IS95_CONST_IR_SIG_IS54B_SSL:I = 0x3

.field public static final IS95_CONST_IR_SIG_IS54B_SS_2:I = 0x4

.field public static final IS95_CONST_IR_SIG_IS54B_S_X4:I = 0x6

.field public static final IS95_CONST_IR_SIG_ISDN_INTGRP:I = 0x1

.field public static final IS95_CONST_IR_SIG_ISDN_NORMAL:I = 0x0

.field public static final IS95_CONST_IR_SIG_ISDN_OFF:I = 0xf

.field public static final IS95_CONST_IR_SIG_ISDN_PAT_3:I = 0x3

.field public static final IS95_CONST_IR_SIG_ISDN_PAT_5:I = 0x5

.field public static final IS95_CONST_IR_SIG_ISDN_PAT_6:I = 0x6

.field public static final IS95_CONST_IR_SIG_ISDN_PAT_7:I = 0x7

.field public static final IS95_CONST_IR_SIG_ISDN_PING:I = 0x4

.field public static final IS95_CONST_IR_SIG_ISDN_SP_PRI:I = 0x2

.field public static final IS95_CONST_IR_SIG_TONE_ABBR_ALRT:I = 0x0

.field public static final IS95_CONST_IR_SIG_TONE_ABB_INT:I = 0x3

.field public static final IS95_CONST_IR_SIG_TONE_ABB_RE:I = 0x5

.field public static final IS95_CONST_IR_SIG_TONE_ANSWER:I = 0x8

.field public static final IS95_CONST_IR_SIG_TONE_BUSY:I = 0x6

.field public static final IS95_CONST_IR_SIG_TONE_CALL_W:I = 0x9

.field public static final IS95_CONST_IR_SIG_TONE_CONFIRM:I = 0x7

.field public static final IS95_CONST_IR_SIG_TONE_DIAL:I = 0x0

.field public static final IS95_CONST_IR_SIG_TONE_INT:I = 0x2

.field public static final IS95_CONST_IR_SIG_TONE_NO_TONE:I = 0x3f

.field public static final IS95_CONST_IR_SIG_TONE_PIP:I = 0xa

.field public static final IS95_CONST_IR_SIG_TONE_REORDER:I = 0x4

.field public static final IS95_CONST_IR_SIG_TONE_RING:I = 0x1

.field public static final TAPIAMSSCDMA_SIGNAL_PITCH_UNKNOWN:I

.field private static hm:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v7, 0x3

    const/4 v6, 0x4

    const/4 v5, 0x1

    const/4 v4, 0x2

    const/4 v3, 0x0

    .line 90
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    .line 136
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v5, v3, v3}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2d

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 141
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v5, v3, v5}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2e

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 147
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v5, v3, v4}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2f

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 152
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v5, v3, v7}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x30

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 157
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v5, v3, v6}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x31

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 162
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x5

    invoke-static {v5, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x32

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 166
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x6

    invoke-static {v5, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x33

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 171
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x7

    invoke-static {v5, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x34

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 176
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xf

    invoke-static {v5, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x62

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 183
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v3, v3}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x22

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 189
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v4, v3}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x22

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 192
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v3, v3}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x22

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 195
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v5, v3}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x22

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 198
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v3, v5}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x23

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 204
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v4, v5}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x23

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 207
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v3, v5}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x23

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 210
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v5, v5}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x23

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 216
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v3, v4}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x24

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 220
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v4, v4}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x24

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 223
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v3, v4}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x24

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 226
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v5, v4}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x24

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 229
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v3, v7}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x25

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 233
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v4, v7}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x25

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 236
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v3, v7}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x25

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 239
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v5, v7}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x25

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 244
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v3, v6}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x26

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 249
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v4, v6}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x26

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 252
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v3, v6}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x26

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 255
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v3, v5, v6}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x26

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 261
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x5

    invoke-static {v3, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x27

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 266
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x5

    invoke-static {v3, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x27

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 269
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x5

    invoke-static {v3, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x27

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 272
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x5

    invoke-static {v3, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x27

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 276
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x6

    invoke-static {v3, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x28

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 281
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x6

    invoke-static {v3, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x28

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 284
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x6

    invoke-static {v3, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x28

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 287
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x6

    invoke-static {v3, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x28

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 293
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x7

    invoke-static {v3, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x29

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 297
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x7

    invoke-static {v3, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x29

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 300
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x7

    invoke-static {v3, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x29

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 303
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x7

    invoke-static {v3, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x29

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 307
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x8

    invoke-static {v3, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2a

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 312
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x8

    invoke-static {v3, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2a

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 315
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x8

    invoke-static {v3, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2a

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 318
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x8

    invoke-static {v3, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2a

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 322
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x9

    invoke-static {v3, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2b

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 327
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x9

    invoke-static {v3, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2b

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 330
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x9

    invoke-static {v3, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2b

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 333
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x9

    invoke-static {v3, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2b

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 338
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xa

    invoke-static {v3, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2c

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 343
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xa

    invoke-static {v3, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2c

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 346
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xa

    invoke-static {v3, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2c

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 349
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xa

    invoke-static {v3, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2c

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 353
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x3f

    invoke-static {v3, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x62

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 362
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v5, v3}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x62

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 365
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v3, v3}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x62

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 368
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v4, v3}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x62

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 372
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v5, v5}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x35

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 375
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v3, v5}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x36

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 378
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v4, v5}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x37

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 381
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v5, v4}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x38

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 384
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v3, v4}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x39

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 387
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v4, v4}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x3a

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 390
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v5, v7}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x3b

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 393
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v3, v7}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x3c

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 396
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v4, v7}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x3d

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 399
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v5, v6}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x3e

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 402
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v3, v6}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x3f

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 405
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v4, v4, v6}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x40

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 408
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x5

    invoke-static {v4, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x41

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 411
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x5

    invoke-static {v4, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x42

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 414
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x5

    invoke-static {v4, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x43

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 417
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x6

    invoke-static {v4, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x44

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 420
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x6

    invoke-static {v4, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x45

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 423
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x6

    invoke-static {v4, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x46

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 426
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x7

    invoke-static {v4, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x47

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 429
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x7

    invoke-static {v4, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x48

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 432
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/4 v1, 0x7

    invoke-static {v4, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x49

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 435
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x8

    invoke-static {v4, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x4a

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 438
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x8

    invoke-static {v4, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x4b

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 441
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x8

    invoke-static {v4, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x4c

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 444
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x9

    invoke-static {v4, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x4d

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 447
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x9

    invoke-static {v4, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x4e

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 450
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x9

    invoke-static {v4, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x4f

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 453
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xa

    invoke-static {v4, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x50

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 456
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xa

    invoke-static {v4, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x51

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 459
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xa

    invoke-static {v4, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x52

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 462
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xb

    invoke-static {v4, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x53

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 465
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xb

    invoke-static {v4, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x54

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 468
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xb

    invoke-static {v4, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x55

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 477
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xc

    invoke-static {v4, v5, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2c

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 480
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xc

    invoke-static {v4, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2c

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 483
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0xc

    invoke-static {v4, v4, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x2c

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 489
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {v6, v3, v3}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x61

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 493
    sget-object v0, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    const/16 v1, 0x3f

    invoke-static {v6, v3, v1}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x61

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 497
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 500
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 501
    return-void
.end method

.method public static getAudioToneFromSignalInfo(III)I
    .locals 3
    .param p0, "signalType"    # I
    .param p1, "alertPitch"    # I
    .param p2, "signal"    # I

    .prologue
    .line 120
    sget-object v1, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->hm:Ljava/util/HashMap;

    invoke-static {p0, p1, p2}, Lcom/lge/internal/telephony/cdma/SignalVZWToneUtil;->signalParamHash(III)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 121
    .local v0, "result":Ljava/lang/Integer;
    if-nez v0, :cond_0

    .line 122
    const/4 v1, -0x1

    .line 124
    :goto_0
    return v1

    :cond_0
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v1

    goto :goto_0
.end method

.method private static signalParamHash(III)Ljava/lang/Integer;
    .locals 3
    .param p0, "signalType"    # I
    .param p1, "alertPitch"    # I
    .param p2, "signal"    # I

    .prologue
    const/16 v0, 0x100

    .line 93
    if-ltz p0, :cond_0

    if-gt p0, v0, :cond_0

    if-gt p1, v0, :cond_0

    if-ltz p1, :cond_0

    if-gt p2, v0, :cond_0

    if-gez p2, :cond_1

    .line 95
    :cond_0
    new-instance v0, Ljava/lang/Integer;

    const/4 v1, -0x1

    invoke-direct {v0, v1}, Ljava/lang/Integer;-><init>(I)V

    .line 106
    :goto_0
    return-object v0

    .line 103
    :cond_1
    const/4 v0, 0x2

    if-eq p0, v0, :cond_2

    .line 104
    const/4 p1, 0x0

    .line 106
    :cond_2
    new-instance v0, Ljava/lang/Integer;

    mul-int/lit16 v1, p0, 0x100

    mul-int/lit16 v1, v1, 0x100

    mul-int/lit16 v2, p1, 0x100

    add-int/2addr v1, v2

    add-int/2addr v1, p2

    invoke-direct {v0, v1}, Ljava/lang/Integer;-><init>(I)V

    goto :goto_0
.end method
