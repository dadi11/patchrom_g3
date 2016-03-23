.class public Lcom/android/internal/telephony/lgdata/LGDBControl;
.super Ljava/lang/Object;
.source "LGDBControl.java"


# static fields
.field private static APN_INDEX:I = 0x0

.field private static AUTH_TYPE_INDEX:I = 0x0

.field private static BEARER_INDEX:I = 0x0

.field private static CARRIER_ENABLED_INDEX:I = 0x0

.field private static ID_INDEX:I = 0x0

.field private static INACTIVITETIMER_INDEX:I = 0x0

.field private static IP_INDEX:I = 0x0

.field static final LOG_TAG:Ljava/lang/String; = "LGDBControl"

.field private static MAX_CONN_INDEX:I = 0x0

.field private static MAX_CONN_T_INDEX:I = 0x0

.field private static MCC_INDEX:I = 0x0

.field private static MMSC_INDEX:I = 0x0

.field private static MMSPORT_INDEX:I = 0x0

.field private static MMSPROXY_INDEX:I = 0x0

.field private static MNC_INDEX:I = 0x0

.field private static NAME_INDEX:I = 0x0

.field private static NUMERIC_INDEX:I = 0x0

.field private static PASSWORD_INDEX:I = 0x0

.field private static PORT_INDEX:I = 0x0

.field private static PROXY_INDEX:I = 0x0

.field private static final QUERY_WHERE_CLAUSE:Ljava/lang/String; = "_id=?"

.field private static SERVER_INDEX:I

.field private static SYSPROP_NETWORK_CODE_SPRINT:Ljava/lang/String;

.field private static SYSPROP_NETWORK_CODE_VZW:Ljava/lang/String;

.field private static TYPE_INDEX:I

.field private static USER_INDEX:I

.field private static WAIT_TIME_INDEX:I

.field private static mUri:Landroid/net/Uri;

.field public static mfeatureset:Ljava/lang/String;

.field private static networkOperator:Ljava/lang/String;

.field private static sProjection:[Ljava/lang/String;

.field private static sVzwProjection:[Ljava/lang/String;


# instance fields
.field private mContext:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    const/16 v3, 0x12

    .line 48
    const/4 v0, 0x0

    sput-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    .line 49
    const-string v0, "310120"

    sput-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->SYSPROP_NETWORK_CODE_SPRINT:Ljava/lang/String;

    .line 51
    const-string v0, "311480"

    sput-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->SYSPROP_NETWORK_CODE_VZW:Ljava/lang/String;

    .line 53
    const-string v0, "ro.afwdata.LGfeatureset"

    const-string v1, "none"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mfeatureset:Ljava/lang/String;

    .line 54
    sput v4, Lcom/android/internal/telephony/lgdata/LGDBControl;->ID_INDEX:I

    .line 55
    sput v5, Lcom/android/internal/telephony/lgdata/LGDBControl;->NAME_INDEX:I

    .line 56
    sput v6, Lcom/android/internal/telephony/lgdata/LGDBControl;->APN_INDEX:I

    .line 57
    sput v7, Lcom/android/internal/telephony/lgdata/LGDBControl;->PROXY_INDEX:I

    .line 58
    const/4 v0, 0x4

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->PORT_INDEX:I

    .line 59
    const/4 v0, 0x5

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->USER_INDEX:I

    .line 60
    const/4 v0, 0x6

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->SERVER_INDEX:I

    .line 61
    const/4 v0, 0x7

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->PASSWORD_INDEX:I

    .line 62
    const/16 v0, 0x8

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSC_INDEX:I

    .line 63
    const/16 v0, 0x9

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->MCC_INDEX:I

    .line 64
    const/16 v0, 0xa

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->MNC_INDEX:I

    .line 65
    const/16 v0, 0xb

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->NUMERIC_INDEX:I

    .line 66
    const/16 v0, 0xc

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSPROXY_INDEX:I

    .line 67
    const/16 v0, 0xd

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSPORT_INDEX:I

    .line 68
    const/16 v0, 0xe

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->AUTH_TYPE_INDEX:I

    .line 69
    const/16 v0, 0xf

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    .line 70
    const/16 v0, 0x10

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->IP_INDEX:I

    .line 71
    const/16 v0, 0x11

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->BEARER_INDEX:I

    .line 73
    sput v3, Lcom/android/internal/telephony/lgdata/LGDBControl;->INACTIVITETIMER_INDEX:I

    .line 77
    sput v3, Lcom/android/internal/telephony/lgdata/LGDBControl;->CARRIER_ENABLED_INDEX:I

    .line 81
    const/16 v0, 0x13

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->MAX_CONN_INDEX:I

    .line 82
    const/16 v0, 0x14

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->MAX_CONN_T_INDEX:I

    .line 83
    const/16 v0, 0x15

    sput v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->WAIT_TIME_INDEX:I

    .line 86
    const-string v0, "content://telephony/carriers"

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    sput-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mUri:Landroid/net/Uri;

    .line 91
    const/16 v0, 0x13

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "_id"

    aput-object v1, v0, v4

    const-string v1, "name"

    aput-object v1, v0, v5

    const-string v1, "apn"

    aput-object v1, v0, v6

    const-string v1, "proxy"

    aput-object v1, v0, v7

    const/4 v1, 0x4

    const-string v2, "port"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "user"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "server"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "password"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "mmsc"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "mcc"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "mnc"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "numeric"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "mmsproxy"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "mmsport"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "authtype"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "type"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "protocol"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "bearer"

    aput-object v2, v0, v1

    const-string v1, "inactivetimer"

    aput-object v1, v0, v3

    sput-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->sProjection:[Ljava/lang/String;

    .line 117
    const/16 v0, 0x16

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "_id"

    aput-object v1, v0, v4

    const-string v1, "name"

    aput-object v1, v0, v5

    const-string v1, "apn"

    aput-object v1, v0, v6

    const-string v1, "proxy"

    aput-object v1, v0, v7

    const/4 v1, 0x4

    const-string v2, "port"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "user"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "server"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "password"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "mmsc"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "mcc"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "mnc"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "numeric"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "mmsproxy"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "mmsport"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "authtype"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "type"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "protocol"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "bearer"

    aput-object v2, v0, v1

    const-string v1, "carrier_enabled"

    aput-object v1, v0, v3

    const/16 v1, 0x13

    const-string v2, "maxconn"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, "maxconn_t"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, "wait_time"

    aput-object v2, v0, v1

    sput-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->sVzwProjection:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 146
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 147
    iput-object p1, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    .line 148
    sget-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mfeatureset:Ljava/lang/String;

    const-string v1, "SPCSBASE"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 150
    sget-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->SYSPROP_NETWORK_CODE_SPRINT:Ljava/lang/String;

    sput-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    .line 151
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!!! SPCSBASE networkOperator :: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 165
    :goto_0
    return-void

    .line 154
    :cond_0
    sget-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mfeatureset:Ljava/lang/String;

    const-string v1, "VZWBASE"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 156
    sget-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->SYSPROP_NETWORK_CODE_VZW:Ljava/lang/String;

    sput-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    .line 157
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!!! VZWBASE networkOperator :: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 162
    :cond_1
    const-string v0, "gsm.sim.operator.numeric"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    .line 163
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!!! NOT SPCSBASE, networkOperator :: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static getVzwLTEApnFromDb(Landroid/content/Context;I)Ljava/lang/String;
    .locals 14
    .param p0, "c"    # Landroid/content/Context;
    .param p1, "row"    # I

    .prologue
    .line 1220
    const/4 v10, 0x0

    .line 1223
    .local v10, "mCursor":Landroid/database/Cursor;
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    .line 1224
    .local v7, "cr":Landroid/content/ContentResolver;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "numeric=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 1228
    .local v3, "where":Ljava/lang/String;
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->sVzwProjection:[Ljava/lang/String;

    const/4 v4, 0x0

    const-string v5, "_id"

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v10

    .line 1231
    if-nez v10, :cond_1

    .line 1233
    const-string v0, "LGDBControl"

    const-string v1, " Cursor is null"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1234
    const/4 v13, 0x0

    .line 1292
    if-eqz v10, :cond_0

    .line 1293
    invoke-interface {v10}, Landroid/database/Cursor;->close()V

    .end local v3    # "where":Ljava/lang/String;
    .end local v7    # "cr":Landroid/content/ContentResolver;
    :cond_0
    :goto_0
    return-object v13

    .line 1237
    .restart local v3    # "where":Ljava/lang/String;
    .restart local v7    # "cr":Landroid/content/ContentResolver;
    :cond_1
    :try_start_1
    invoke-interface {v10}, Landroid/database/Cursor;->moveToFirst()Z

    .line 1238
    invoke-interface {v10}, Landroid/database/Cursor;->getCount()I

    move-result v6

    .line 1239
    .local v6, "count":I
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "now in the db for "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " \'s count is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1241
    if-gt v6, p1, :cond_2

    .line 1243
    invoke-interface {v10}, Landroid/database/Cursor;->close()V

    .line 1244
    const-string v13, "0"
    :try_end_1
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1292
    if-eqz v10, :cond_0

    .line 1293
    invoke-interface {v10}, Landroid/database/Cursor;->close()V

    goto :goto_0

    .line 1246
    :cond_2
    :try_start_2
    invoke-interface {v10, p1}, Landroid/database/Cursor;->move(I)Z

    .line 1248
    sget v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->ID_INDEX:I

    invoke-interface {v10, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v9

    .line 1249
    .local v9, "key":Ljava/lang/String;
    invoke-static {v9}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v12

    .line 1250
    .local v12, "pos":I
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "your pos"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1252
    const-string v11, "LTE|EHRPD"

    .line 1254
    .local v11, "myBearer":Ljava/lang/String;
    sget v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->BEARER_INDEX:I

    invoke-interface {v10, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "14"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 1256
    const-string v11, "LTE"

    .line 1263
    :cond_3
    :goto_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->NAME_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->APN_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->PROXY_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->PORT_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->USER_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->PASSWORD_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->SERVER_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSC_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSPROXY_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSPORT_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->AUTH_TYPE_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->IP_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->CARRIER_ENABLED_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->BEARER_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->MAX_CONN_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->MAX_CONN_T_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->WAIT_TIME_INDEX:I

    invoke-interface {v10, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    .line 1283
    .local v13, "result":Ljava/lang/String;
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getting info is !! "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1292
    if-eqz v10, :cond_0

    .line 1293
    invoke-interface {v10}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 1258
    .end local v13    # "result":Ljava/lang/String;
    :cond_4
    :try_start_3
    sget v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->BEARER_INDEX:I

    invoke-interface {v10, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "13"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1260
    const-string v11, "EHRPD"
    :try_end_3
    .catch Ljava/lang/IllegalStateException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto/16 :goto_1

    .line 1286
    .end local v3    # "where":Ljava/lang/String;
    .end local v6    # "count":I
    .end local v7    # "cr":Landroid/content/ContentResolver;
    .end local v9    # "key":Ljava/lang/String;
    .end local v11    # "myBearer":Ljava/lang/String;
    .end local v12    # "pos":I
    :catch_0
    move-exception v8

    .line 1288
    .local v8, "e":Ljava/lang/IllegalStateException;
    :try_start_4
    const-string v0, "LGDBControl"

    const-string v1, "IllegalStateException getVzwLTEApnFromDb"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 1289
    const/4 v13, 0x0

    .line 1292
    if-eqz v10, :cond_0

    .line 1293
    invoke-interface {v10}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 1292
    .end local v8    # "e":Ljava/lang/IllegalStateException;
    :catchall_0
    move-exception v0

    if-eqz v10, :cond_5

    .line 1293
    invoke-interface {v10}, Landroid/database/Cursor;->close()V

    :cond_5
    throw v0
.end method

.method private queryApnValues(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 13
    .param p1, "type"    # Ljava/lang/String;
    .param p2, "item"    # Ljava/lang/String;

    .prologue
    .line 1503
    const/4 v11, 0x0

    .line 1505
    .local v11, "mCursor":Landroid/database/Cursor;
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "queryApnValues - networkOperator : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1510
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "numeric=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 1514
    .local v4, "where":Ljava/lang/String;
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    sget-object v3, Lcom/android/internal/telephony/lgdata/LGDBControl;->sVzwProjection:[Ljava/lang/String;

    const/4 v5, 0x0

    const-string v6, "_id"

    invoke-static/range {v0 .. v6}, Landroid/database/sqlite/SqliteWrapper;->query(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v11

    .line 1516
    if-nez v11, :cond_1

    .line 1518
    const-string v0, "LGDBControl"

    const-string v1, " Cursor is null"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1519
    const/4 v12, 0x0

    .line 1548
    if-eqz v11, :cond_0

    .line 1549
    invoke-interface {v11}, Landroid/database/Cursor;->close()V

    .end local v4    # "where":Ljava/lang/String;
    :cond_0
    :goto_0
    return-object v12

    .line 1522
    .restart local v4    # "where":Ljava/lang/String;
    :cond_1
    :try_start_1
    invoke-interface {v11}, Landroid/database/Cursor;->moveToFirst()Z

    .line 1523
    invoke-interface {v11}, Landroid/database/Cursor;->getCount()I

    move-result v7

    .line 1524
    .local v7, "count":I
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "now in the db for "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " \'s count is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1526
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_1
    if-ge v9, v7, :cond_3

    .line 1529
    sget v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    invoke-interface {v11, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0, p1}, Lcom/android/internal/telephony/lgdata/LGDBControl;->isEqualApnType(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1531
    invoke-interface {v11, p2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v10

    .line 1532
    .local v10, "index":I
    invoke-interface {v11, v10}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v12

    .line 1533
    .local v12, "result":Ljava/lang/String;
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "query value is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", index : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", type : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1548
    if-eqz v11, :cond_0

    .line 1549
    invoke-interface {v11}, Landroid/database/Cursor;->close()V

    goto :goto_0

    .line 1537
    .end local v10    # "index":I
    .end local v12    # "result":Ljava/lang/String;
    :cond_2
    :try_start_2
    invoke-interface {v11}, Landroid/database/Cursor;->moveToNext()Z
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1526
    add-int/lit8 v9, v9, 0x1

    goto :goto_1

    .line 1540
    :cond_3
    const/4 v12, 0x0

    .line 1548
    if-eqz v11, :cond_0

    .line 1549
    invoke-interface {v11}, Landroid/database/Cursor;->close()V

    goto :goto_0

    .line 1542
    .end local v4    # "where":Ljava/lang/String;
    .end local v7    # "count":I
    .end local v9    # "i":I
    :catch_0
    move-exception v8

    .line 1544
    .local v8, "e":Ljava/lang/Exception;
    :try_start_3
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Exception queryApnValues - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1545
    const/4 v12, 0x0

    .line 1548
    if-eqz v11, :cond_0

    .line 1549
    invoke-interface {v11}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 1548
    .end local v8    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v0

    if-eqz v11, :cond_4

    .line 1549
    invoke-interface {v11}, Landroid/database/Cursor;->close()V

    :cond_4
    throw v0
.end method

.method public static updateApnDBForVZW(Landroid/content/Context;Ljava/lang/String;I)Z
    .locals 24
    .param p0, "c"    # Landroid/content/Context;
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "Set_id"    # I

    .prologue
    .line 1104
    const-string v2, "phone"

    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Landroid/telephony/TelephonyManager;

    .line 1107
    .local v15, "mTelephonyManager":Landroid/telephony/TelephonyManager;
    const-string v2, ","

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v18

    .line 1109
    .local v18, "parm":[Ljava/lang/String;
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "parm length = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, v18

    array-length v4, v0

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1111
    const/4 v11, 0x0

    .local v11, "i":I
    :goto_0
    move-object/from16 v0, v18

    array-length v2, v0

    if-ge v11, v2, :cond_0

    .line 1113
    const-string v2, "LGDBControl"

    aget-object v3, v18, v11

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1111
    add-int/lit8 v11, v11, 0x1

    goto :goto_0

    .line 1116
    :cond_0
    const-string v16, "0"

    .line 1117
    .local v16, "mcc":Ljava/lang/String;
    const-string v17, "0"

    .line 1119
    .local v17, "mnc":Ljava/lang/String;
    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    if-eqz v2, :cond_1

    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x5

    if-ge v2, v3, :cond_3

    .line 1121
    :cond_1
    const-string v2, "LGDBControl"

    const-string v3, "[updateApnDBupdateApnDB]home oper is bad. error "

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1122
    const/4 v2, 0x0

    .line 1213
    :cond_2
    :goto_1
    return v2

    .line 1125
    :cond_3
    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v13

    .line 1127
    .local v13, "length":I
    const/4 v2, 0x5

    if-ge v13, v2, :cond_4

    .line 1129
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "home oper is bad. error "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1130
    const/4 v2, 0x0

    goto :goto_1

    .line 1133
    :cond_4
    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    const/4 v3, 0x0

    const/4 v4, 0x3

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v16

    .line 1134
    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    const/4 v3, 0x3

    invoke-virtual {v2, v3, v13}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v17

    .line 1136
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SIM Info reading Success "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, v16

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ","

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, v17

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1138
    const/4 v14, 0x0

    .line 1142
    .local v14, "mCursor":Landroid/database/Cursor;
    :try_start_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "numeric=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 1145
    .local v6, "where":Ljava/lang/String;
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    sget-object v4, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    sget-object v5, Lcom/android/internal/telephony/lgdata/LGDBControl;->sVzwProjection:[Ljava/lang/String;

    const/4 v7, 0x0

    const-string v8, "_id"

    move-object/from16 v2, p0

    invoke-static/range {v2 .. v8}, Landroid/database/sqlite/SqliteWrapper;->query(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v14

    .line 1147
    if-nez v14, :cond_5

    .line 1149
    const-string v2, "LGDBControl"

    const-string v3, " Cursor is null"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1150
    const/4 v2, 0x0

    .line 1212
    if-eqz v14, :cond_2

    .line 1213
    invoke-interface {v14}, Landroid/database/Cursor;->close()V

    goto/16 :goto_1

    .line 1153
    :cond_5
    :try_start_1
    invoke-interface {v14}, Landroid/database/Cursor;->moveToFirst()Z

    .line 1154
    invoke-interface {v14}, Landroid/database/Cursor;->getCount()I

    move-result v9

    .line 1156
    .local v9, "count":I
    move/from16 v0, p2

    if-ge v9, v0, :cond_6

    .line 1158
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "set id is bad id : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, p2

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1159
    invoke-interface {v14}, Landroid/database/Cursor;->close()V
    :try_end_1
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1160
    const/4 v2, 0x0

    .line 1212
    if-eqz v14, :cond_2

    .line 1213
    invoke-interface {v14}, Landroid/database/Cursor;->close()V

    goto/16 :goto_1

    .line 1163
    :cond_6
    :try_start_2
    move/from16 v0, p2

    invoke-interface {v14, v0}, Landroid/database/Cursor;->move(I)Z

    .line 1165
    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->ID_INDEX:I

    invoke-interface {v14, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v12

    .line 1167
    .local v12, "key":Ljava/lang/String;
    invoke-static {v12}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v19

    .line 1168
    .local v19, "pos":I
    sget-object v2, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    move/from16 v0, v19

    int-to-long v4, v0

    invoke-static {v2, v4, v5}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;

    move-result-object v22

    .line 1170
    .local v22, "url":Landroid/net/Uri;
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[updateApnDBForVZW]numeric : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1171
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[updateApnDBForVZW]your pos "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, v19

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1173
    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    invoke-interface {v14, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v21

    .line 1174
    .local v21, "type":Ljava/lang/String;
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[Taegil] Key is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1176
    new-instance v23, Landroid/content/ContentValues;

    invoke-direct/range {v23 .. v23}, Landroid/content/ContentValues;-><init>()V

    .line 1178
    .local v23, "values":Landroid/content/ContentValues;
    const-string v2, "name"

    const/4 v3, 0x0

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1179
    const-string v2, "apn"

    const/4 v3, 0x1

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1180
    const-string v2, "proxy"

    const/4 v3, 0x2

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1181
    const-string v2, "port"

    const/4 v3, 0x3

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1182
    const-string v2, "user"

    const/4 v3, 0x4

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1183
    const-string v2, "password"

    const/4 v3, 0x5

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1184
    const-string v2, "server"

    const/4 v3, 0x6

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1185
    const-string v2, "mmsc"

    const/4 v3, 0x7

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1186
    const-string v2, "mmsproxy"

    const/16 v3, 0x8

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1187
    const-string v2, "mmsport"

    const/16 v3, 0x9

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1188
    const-string v2, "mcc"

    move-object/from16 v0, v23

    move-object/from16 v1, v16

    invoke-virtual {v0, v2, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1189
    const-string v2, "mnc"

    move-object/from16 v0, v23

    move-object/from16 v1, v17

    invoke-virtual {v0, v2, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1190
    const-string v2, "authtype"

    const/16 v3, 0xa

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1191
    const-string v2, "type"

    const/16 v3, 0xb

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1192
    const-string v2, "protocol"

    const/16 v3, 0xc

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1193
    const-string v2, "carrier_enabled"

    const/16 v3, 0xd

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1194
    const-string v2, "bearer"

    const/16 v3, 0xe

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1195
    const-string v2, "maxconn"

    const/16 v3, 0xf

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1196
    const-string v2, "maxconn_t"

    const/16 v3, 0x10

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1197
    const-string v2, "wait_time"

    const/16 v3, 0x11

    aget-object v3, v18, v3

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1198
    const-string v2, "numeric"

    sget-object v3, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1201
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object/from16 v0, v22

    move-object/from16 v1, v23

    invoke-virtual {v2, v0, v1, v3, v4}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v20

    .line 1203
    .local v20, "result":I
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Updated "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, v20

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " Rows Success"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1205
    const/4 v2, 0x1

    .line 1212
    if-eqz v14, :cond_2

    .line 1213
    invoke-interface {v14}, Landroid/database/Cursor;->close()V

    goto/16 :goto_1

    .line 1207
    .end local v6    # "where":Ljava/lang/String;
    .end local v9    # "count":I
    .end local v12    # "key":Ljava/lang/String;
    .end local v19    # "pos":I
    .end local v20    # "result":I
    .end local v21    # "type":Ljava/lang/String;
    .end local v22    # "url":Landroid/net/Uri;
    .end local v23    # "values":Landroid/content/ContentValues;
    :catch_0
    move-exception v10

    .line 1209
    .local v10, "e":Ljava/lang/IllegalStateException;
    const/4 v2, 0x0

    .line 1212
    if-eqz v14, :cond_2

    .line 1213
    invoke-interface {v14}, Landroid/database/Cursor;->close()V

    goto/16 :goto_1

    .line 1212
    .end local v10    # "e":Ljava/lang/IllegalStateException;
    :catchall_0
    move-exception v2

    if-eqz v14, :cond_7

    .line 1213
    invoke-interface {v14}, Landroid/database/Cursor;->close()V

    :cond_7
    throw v2
.end method

.method private updateApnValues(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 20
    .param p1, "type"    # Ljava/lang/String;
    .param p2, "item"    # Ljava/lang/String;
    .param p3, "values"    # Ljava/lang/String;

    .prologue
    .line 1429
    const/4 v15, 0x0

    .line 1431
    .local v15, "mCursor":Landroid/database/Cursor;
    const-string v4, "LGDBControl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "updateApnValues - networkOperator : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1433
    new-instance v18, Landroid/content/ContentValues;

    invoke-direct/range {v18 .. v18}, Landroid/content/ContentValues;-><init>()V

    .line 1438
    .local v18, "setValues":Landroid/content/ContentValues;
    :try_start_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "numeric=\""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 1442
    .local v8, "where":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    sget-object v6, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    sget-object v7, Lcom/android/internal/telephony/lgdata/LGDBControl;->sVzwProjection:[Ljava/lang/String;

    const/4 v9, 0x0

    const-string v10, "_id"

    invoke-static/range {v4 .. v10}, Landroid/database/sqlite/SqliteWrapper;->query(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v15

    .line 1444
    if-nez v15, :cond_1

    .line 1446
    const-string v4, "LGDBControl"

    const-string v5, " Cursor is null"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1447
    const/4 v4, 0x0

    .line 1493
    if-eqz v15, :cond_0

    .line 1494
    invoke-interface {v15}, Landroid/database/Cursor;->close()V

    .end local v8    # "where":Ljava/lang/String;
    :cond_0
    :goto_0
    return v4

    .line 1450
    .restart local v8    # "where":Ljava/lang/String;
    :cond_1
    :try_start_1
    invoke-interface {v15}, Landroid/database/Cursor;->moveToFirst()Z

    .line 1451
    invoke-interface {v15}, Landroid/database/Cursor;->getCount()I

    move-result v11

    .line 1452
    .local v11, "count":I
    const-string v4, "LGDBControl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "now in the db for "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " \'s count is "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1454
    const/4 v13, 0x0

    .local v13, "i":I
    :goto_1
    if-ge v13, v11, :cond_4

    .line 1456
    sget v4, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    invoke-interface {v15, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-virtual {v0, v4, v1}, Lcom/android/internal/telephony/lgdata/LGDBControl;->isEqualApnType(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 1458
    sget v4, Lcom/android/internal/telephony/lgdata/LGDBControl;->ID_INDEX:I

    invoke-interface {v15, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v14

    .line 1459
    .local v14, "key":Ljava/lang/String;
    invoke-static {v14}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v16

    .line 1461
    .local v16, "pos":I
    sget-object v4, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    move/from16 v0, v16

    int-to-long v6, v0

    invoke-static {v4, v6, v7}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;

    move-result-object v19

    .line 1463
    .local v19, "url":Landroid/net/Uri;
    const-string v4, "LGDBControl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "current pos : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move/from16 v0, v16

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ", mCursor.getPosition : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-interface {v15}, Landroid/database/Cursor;->getPosition()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1465
    move-object/from16 v0, v18

    move-object/from16 v1, p2

    move-object/from16 v2, p3

    invoke-virtual {v0, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1467
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object/from16 v0, v19

    move-object/from16 v1, v18

    invoke-virtual {v4, v0, v1, v5, v6}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v17

    .line 1469
    .local v17, "result":I
    const-string v4, "LGDBControl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "update value is "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, p3

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ", item : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, p2

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ", result : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move/from16 v0, v17

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1471
    if-gtz v17, :cond_2

    .line 1473
    const/4 v4, 0x0

    .line 1493
    if-eqz v15, :cond_0

    .line 1494
    invoke-interface {v15}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 1477
    :cond_2
    const/4 v4, 0x1

    .line 1493
    if-eqz v15, :cond_0

    .line 1494
    invoke-interface {v15}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 1482
    .end local v14    # "key":Ljava/lang/String;
    .end local v16    # "pos":I
    .end local v17    # "result":I
    .end local v19    # "url":Landroid/net/Uri;
    :cond_3
    :try_start_2
    invoke-interface {v15}, Landroid/database/Cursor;->moveToNext()Z
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1454
    add-int/lit8 v13, v13, 0x1

    goto/16 :goto_1

    .line 1485
    :cond_4
    const/4 v4, 0x0

    .line 1493
    if-eqz v15, :cond_0

    .line 1494
    invoke-interface {v15}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 1487
    .end local v8    # "where":Ljava/lang/String;
    .end local v11    # "count":I
    .end local v13    # "i":I
    :catch_0
    move-exception v12

    .line 1489
    .local v12, "e":Ljava/lang/Exception;
    :try_start_3
    const-string v4, "LGDBControl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Exception setApnValues - "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1490
    const/4 v4, 0x0

    .line 1493
    if-eqz v15, :cond_0

    .line 1494
    invoke-interface {v15}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 1493
    .end local v12    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v4

    if-eqz v15, :cond_5

    .line 1494
    invoke-interface {v15}, Landroid/database/Cursor;->close()V

    :cond_5
    throw v4
.end method


# virtual methods
.method public backupAPN(Landroid/content/Context;Ljava/lang/String;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "apnBackup"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 665
    if-nez p2, :cond_0

    .line 667
    :try_start_0
    new-instance v4, Ljava/io/BufferedWriter;

    new-instance v5, Ljava/io/FileWriter;

    new-instance v6, Ljava/lang/String;

    const-string v7, "/persist-lg/LGE_RC/apn_backup"

    invoke-direct {v6, v7}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    invoke-direct {v5, v6}, Ljava/io/FileWriter;-><init>(Ljava/lang/String;)V

    invoke-direct {v4, v5}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    .line 668
    .local v4, "outApnFile":Ljava/io/BufferedWriter;
    const-string v1, ""

    .line 670
    .local v1, "buffer":Ljava/lang/String;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    const/16 v5, 0x9

    if-ge v3, v5, :cond_2

    .line 672
    const/4 v5, 0x0

    const/4 v6, 0x1

    invoke-virtual {p0, v3, v5, v6}, Lcom/android/internal/telephony/lgdata/LGDBControl;->getAPNString(IZZ)Ljava/lang/String;

    move-result-object v0

    .line 674
    .local v0, "APNValue":Ljava/lang/String;
    if-nez v0, :cond_1

    .line 676
    const-string v5, "APN Backup"

    const-string v6, "APNValue is NULL"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 696
    .end local v0    # "APNValue":Ljava/lang/String;
    .end local v1    # "buffer":Ljava/lang/String;
    .end local v3    # "i":I
    .end local v4    # "outApnFile":Ljava/io/BufferedWriter;
    :cond_0
    :goto_1
    return-void

    .line 679
    .restart local v0    # "APNValue":Ljava/lang/String;
    .restart local v1    # "buffer":Ljava/lang/String;
    .restart local v3    # "i":I
    .restart local v4    # "outApnFile":Ljava/io/BufferedWriter;
    :cond_1
    const-string v5, "0"

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 681
    const-string v5, "APN Backup"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, " Backup APN table : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " None"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 686
    .end local v0    # "APNValue":Ljava/lang/String;
    :cond_2
    invoke-virtual {v4, v1}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 687
    invoke-virtual {v4}, Ljava/io/BufferedWriter;->flush()V

    .line 688
    invoke-virtual {v4}, Ljava/io/BufferedWriter;->close()V

    .line 689
    const-string v5, "APN Backup"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, " Backup APN table! "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 692
    .end local v1    # "buffer":Ljava/lang/String;
    .end local v3    # "i":I
    .end local v4    # "outApnFile":Ljava/io/BufferedWriter;
    :catch_0
    move-exception v2

    .line 694
    .local v2, "e":Ljava/lang/Exception;
    const-string v5, "APN Backup"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Backup APN table"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 684
    .end local v2    # "e":Ljava/lang/Exception;
    .restart local v0    # "APNValue":Ljava/lang/String;
    .restart local v1    # "buffer":Ljava/lang/String;
    .restart local v3    # "i":I
    .restart local v4    # "outApnFile":Ljava/io/BufferedWriter;
    :cond_3
    :try_start_1
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " 1,"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v1

    .line 670
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_0
.end method

.method public backupAPN(Ljava/lang/String;)V
    .locals 9
    .param p1, "filename"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 700
    if-eqz p1, :cond_0

    .line 704
    :try_start_0
    const-string v4, "/persist-lg/LGE_RC/"

    .line 705
    .local v4, "mFilePath":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 706
    new-instance v5, Ljava/io/BufferedWriter;

    new-instance v6, Ljava/io/FileWriter;

    invoke-direct {v6, v4}, Ljava/io/FileWriter;-><init>(Ljava/lang/String;)V

    invoke-direct {v5, v6}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    .line 707
    .local v5, "outApnFile":Ljava/io/BufferedWriter;
    const-string v1, ""

    .line 709
    .local v1, "buffer":Ljava/lang/String;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    const/16 v6, 0x9

    if-ge v3, v6, :cond_2

    .line 711
    const/4 v6, 0x0

    const/4 v7, 0x1

    invoke-virtual {p0, v3, v6, v7}, Lcom/android/internal/telephony/lgdata/LGDBControl;->getAPNString(IZZ)Ljava/lang/String;

    move-result-object v0

    .line 713
    .local v0, "APNValue":Ljava/lang/String;
    if-nez v0, :cond_1

    .line 715
    const-string v6, "APN Backup"

    const-string v7, "APNValue is NULL"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 735
    .end local v0    # "APNValue":Ljava/lang/String;
    .end local v1    # "buffer":Ljava/lang/String;
    .end local v3    # "i":I
    .end local v4    # "mFilePath":Ljava/lang/String;
    .end local v5    # "outApnFile":Ljava/io/BufferedWriter;
    :cond_0
    :goto_1
    return-void

    .line 718
    .restart local v0    # "APNValue":Ljava/lang/String;
    .restart local v1    # "buffer":Ljava/lang/String;
    .restart local v3    # "i":I
    .restart local v4    # "mFilePath":Ljava/lang/String;
    .restart local v5    # "outApnFile":Ljava/io/BufferedWriter;
    :cond_1
    const-string v6, "0"

    invoke-virtual {v0, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 720
    const-string v6, "APN Backup"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, " Backup APN table : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " None"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 725
    .end local v0    # "APNValue":Ljava/lang/String;
    :cond_2
    invoke-virtual {v5, v1}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 726
    invoke-virtual {v5}, Ljava/io/BufferedWriter;->flush()V

    .line 727
    invoke-virtual {v5}, Ljava/io/BufferedWriter;->close()V

    .line 728
    const-string v6, "APN Backup"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " Backup APN table! "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 730
    .end local v1    # "buffer":Ljava/lang/String;
    .end local v3    # "i":I
    .end local v4    # "mFilePath":Ljava/lang/String;
    .end local v5    # "outApnFile":Ljava/io/BufferedWriter;
    :catch_0
    move-exception v2

    .line 732
    .local v2, "e":Ljava/lang/Exception;
    const-string v6, "APN Backup"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Backup APN table"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 723
    .end local v2    # "e":Ljava/lang/Exception;
    .restart local v0    # "APNValue":Ljava/lang/String;
    .restart local v1    # "buffer":Ljava/lang/String;
    .restart local v3    # "i":I
    .restart local v4    # "mFilePath":Ljava/lang/String;
    .restart local v5    # "outApnFile":Ljava/io/BufferedWriter;
    :cond_3
    :try_start_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " 1,"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v1

    .line 709
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_0
.end method

.method public checkApnUpdate(I)Z
    .locals 10
    .param p1, "Set_id"    # I

    .prologue
    const/4 v9, 0x0

    .line 1060
    const/4 v8, 0x0

    .line 1062
    .local v8, "mCursor":Landroid/database/Cursor;
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "checkId networkOperator :: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1064
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "numeric=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 1070
    .local v4, "where":Ljava/lang/String;
    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    sget-object v3, Lcom/android/internal/telephony/lgdata/LGDBControl;->sVzwProjection:[Ljava/lang/String;

    const/4 v5, 0x0

    const-string v6, "_id"

    invoke-static/range {v0 .. v6}, Landroid/database/sqlite/SqliteWrapper;->query(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v8

    .line 1071
    if-nez v8, :cond_2

    .line 1073
    const-string v0, "LGDBControl"

    const-string v1, " Cursor is null"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1095
    if-eqz v8, :cond_0

    .line 1096
    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    :cond_0
    move v0, v9

    :cond_1
    :goto_0
    return v0

    .line 1076
    :cond_2
    :try_start_1
    invoke-interface {v8}, Landroid/database/Cursor;->moveToFirst()Z

    .line 1077
    invoke-interface {v8, p1}, Landroid/database/Cursor;->move(I)Z

    .line 1078
    sget v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    invoke-interface {v8, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "default"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    sget v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    invoke-interface {v8, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "admin"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 1080
    :cond_3
    invoke-interface {v8}, Landroid/database/Cursor;->close()V
    :try_end_1
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1081
    const/4 v0, 0x1

    .line 1095
    if-eqz v8, :cond_1

    .line 1096
    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    goto :goto_0

    .line 1085
    :cond_4
    :try_start_2
    invoke-interface {v8}, Landroid/database/Cursor;->close()V
    :try_end_2
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1095
    if-eqz v8, :cond_5

    .line 1096
    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    :cond_5
    move v0, v9

    goto :goto_0

    .line 1089
    :catch_0
    move-exception v7

    .line 1091
    .local v7, "e":Ljava/lang/IllegalStateException;
    :try_start_3
    const-string v0, "LGDBControl"

    const-string v1, "IllegalStateException checkApnUpdate"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1095
    if-eqz v8, :cond_6

    .line 1096
    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    :cond_6
    move v0, v9

    goto :goto_0

    .line 1095
    .end local v7    # "e":Ljava/lang/IllegalStateException;
    :catchall_0
    move-exception v0

    if-eqz v8, :cond_7

    .line 1096
    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    :cond_7
    throw v0
.end method

.method public checkId(I)Z
    .locals 9
    .param p1, "Set_id"    # I

    .prologue
    .line 214
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "checkId networkOperator :: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 215
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "numeric=\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 220
    .local v3, "where":Ljava/lang/String;
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->sProjection:[Ljava/lang/String;

    const/4 v4, 0x0

    const-string v5, "_id"

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v8

    .line 222
    .local v8, "mCursor":Landroid/database/Cursor;
    if-nez v8, :cond_0

    .line 224
    const-string v0, "LGDBControl"

    const-string v1, " Cursor is null"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 225
    const/4 v0, 0x0

    .line 240
    :goto_0
    return v0

    .line 228
    :cond_0
    invoke-interface {v8}, Landroid/database/Cursor;->moveToFirst()Z

    .line 229
    invoke-interface {v8}, Landroid/database/Cursor;->getCount()I

    move-result v6

    .line 231
    .local v6, "count":I
    if-gt v6, p1, :cond_1

    .line 233
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setting num is bigger than real num so make dummy  mCursor.count :: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 234
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_1
    sub-int v0, p1, v6

    if-gt v7, v0, :cond_1

    .line 236
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LGDBControl;->makedummy()Z

    .line 234
    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    .line 239
    .end local v7    # "i":I
    :cond_1
    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    .line 240
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public getAPNString(I)Ljava/lang/String;
    .locals 3
    .param p1, "id"    # I

    .prologue
    .line 1037
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!!! get APN Called "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1038
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-static {v0, p1}, Lcom/android/internal/telephony/lgdata/LGDBControl;->getVzwLTEApnFromDb(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getAPNString(IZ)Ljava/lang/String;
    .locals 3
    .param p1, "id"    # I
    .param p2, "dummy"    # Z

    .prologue
    .line 169
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!!! get APN Called "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 170
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p1, p2, v1}, Lcom/android/internal/telephony/lgdata/LGDBControl;->getSpLTEApnFromDb(Landroid/content/Context;IZZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getAPNString(IZZ)Ljava/lang/String;
    .locals 3
    .param p1, "id"    # I
    .param p2, "dummy"    # Z
    .param p3, "restoreAPNorBackupAPN"    # Z

    .prologue
    .line 180
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!!! get APN Called "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 181
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!!! get APN Called restoreAPNorBackupApn is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 182
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {p0, v0, p1, p2, p3}, Lcom/android/internal/telephony/lgdata/LGDBControl;->getSpLTEApnFromDb(Landroid/content/Context;IZZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getAPNStringforSYSPROP(IZ)Ljava/lang/String;
    .locals 3
    .param p1, "id"    # I
    .param p2, "dummy"    # Z

    .prologue
    .line 175
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!!! get APN Called "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 176
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p1, p2, v1}, Lcom/android/internal/telephony/lgdata/LGDBControl;->getSpLTEApnFromDbSYSPROP(Landroid/content/Context;IZZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getAPNType(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "apnType"    # Ljava/lang/String;

    .prologue
    .line 301
    const/4 v2, 0x0

    new-array v0, v2, [Ljava/lang/String;

    .line 302
    .local v0, "apnTypeTemp":[Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 303
    const-string v2, ","

    invoke-virtual {p1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 304
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_1

    .line 305
    aget-object v2, v0, v1

    const-string v3, "default"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 306
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getAPNType(expect default):: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-object v4, v0, v1

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 307
    aget-object p1, v0, v1

    .line 312
    .end local v1    # "i":I
    .end local p1    # "apnType":Ljava/lang/String;
    :goto_1
    return-object p1

    .line 304
    .restart local v1    # "i":I
    .restart local p1    # "apnType":Ljava/lang/String;
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 311
    .end local v1    # "i":I
    :cond_1
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getAPNType :: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public getApnValues(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p1, "type"    # Ljava/lang/String;
    .param p2, "item"    # Ljava/lang/String;

    .prologue
    .line 1302
    const/4 v1, 0x0

    .line 1304
    .local v1, "result":Ljava/lang/String;
    const-string v3, "_id"

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "apn"

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "maxconn"

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "maxconn_t"

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "wait_time"

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 1310
    :cond_0
    invoke-direct {p0, p1, p2}, Lcom/android/internal/telephony/lgdata/LGDBControl;->queryApnValues(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1311
    const-string v3, "LGDBControl"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getApn type : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " column is : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " result is : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v0, v1

    .line 1350
    :goto_0
    return-object v0

    .line 1314
    :cond_1
    const-string v3, "protocol"

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_6

    .line 1316
    invoke-direct {p0, p1, p2}, Lcom/android/internal/telephony/lgdata/LGDBControl;->queryApnValues(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1318
    .local v0, "ip":Ljava/lang/String;
    if-eqz v0, :cond_2

    .line 1319
    const-string v3, "IP"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 1320
    const-string v0, "IPV4"

    .line 1329
    :cond_2
    :goto_1
    const-string v3, "LGDBControl"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getApn type : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " column is : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " result is : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 1321
    :cond_3
    const-string v3, "IPV6"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 1322
    const-string v0, "IPV6"

    goto :goto_1

    .line 1323
    :cond_4
    const-string v3, "IPV4V6"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 1324
    const-string v0, "IPV4 and IPV6"

    goto :goto_1

    .line 1326
    :cond_5
    const/4 v0, 0x0

    goto :goto_1

    .line 1332
    .end local v0    # "ip":Ljava/lang/String;
    :cond_6
    const-string v3, "carrier_enabled"

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_a

    .line 1334
    invoke-direct {p0, p1, p2}, Lcom/android/internal/telephony/lgdata/LGDBControl;->queryApnValues(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 1336
    .local v2, "status":Ljava/lang/String;
    if-eqz v2, :cond_7

    .line 1337
    const-string v3, "1"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_8

    .line 1338
    const-string v2, "true"

    .line 1346
    :cond_7
    :goto_2
    const-string v3, "LGDBControl"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getApn type : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " column is : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " result is : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v0, v2

    .line 1347
    goto/16 :goto_0

    .line 1339
    :cond_8
    const-string v3, "0"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_9

    .line 1340
    const-string v2, "false"

    goto :goto_2

    .line 1342
    :cond_9
    const/4 v2, 0x0

    goto :goto_2

    .line 1350
    .end local v2    # "status":Ljava/lang/String;
    :cond_a
    const/4 v0, 0x0

    goto/16 :goto_0
.end method

.method public getMMSInfo(Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p1, "numeric"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x0

    .line 414
    const-string v8, ""

    .line 416
    .local v8, "result":Ljava/lang/String;
    const-string v3, "type LIKE \'%default%\' OR type LIKE \'%mms%\'"

    .line 418
    .local v3, "where":Ljava/lang/String;
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->sProjection:[Ljava/lang/String;

    move-object v5, v4

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v7

    .line 423
    .local v7, "mCursor":Landroid/database/Cursor;
    if-eqz v7, :cond_2

    invoke-interface {v7}, Landroid/database/Cursor;->getCount()I

    move-result v0

    if-lez v0, :cond_2

    .line 424
    invoke-interface {v7}, Landroid/database/Cursor;->moveToFirst()Z

    .line 425
    :goto_0
    invoke-interface {v7}, Landroid/database/Cursor;->isAfterLast()Z

    move-result v0

    if-nez v0, :cond_1

    .line 426
    sget v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->NUMERIC_INDEX:I

    invoke-interface {v7, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v6

    .line 427
    .local v6, "dbNumeric":Ljava/lang/String;
    invoke-virtual {v6, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->BEARER_INDEX:I

    invoke-interface {v7, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "0"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 428
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSC_INDEX:I

    invoke-interface {v7, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSPROXY_INDEX:I

    invoke-interface {v7, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSPORT_INDEX:I

    invoke-interface {v7, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 433
    :cond_0
    invoke-interface {v7}, Landroid/database/Cursor;->moveToNext()Z

    goto :goto_0

    .line 435
    .end local v6    # "dbNumeric":Ljava/lang/String;
    :cond_1
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    .line 437
    :cond_2
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getMMSInfo info is !! "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 438
    return-object v8
.end method

.method public getSpLTEApnFromDb(Landroid/content/Context;IZZ)Ljava/lang/String;
    .locals 16
    .param p1, "c"    # Landroid/content/Context;
    .param p2, "row"    # I
    .param p3, "dummy"    # Z
    .param p4, "restoreAPNorBackupAPN"    # Z

    .prologue
    .line 841
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v9

    .line 843
    .local v9, "cr":Landroid/content/ContentResolver;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "numeric=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 847
    .local v4, "where":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    sget-object v3, Lcom/android/internal/telephony/lgdata/LGDBControl;->sProjection:[Ljava/lang/String;

    const/4 v5, 0x0

    const-string v6, "_id"

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v12

    .line 850
    .local v12, "mCursor":Landroid/database/Cursor;
    if-nez v12, :cond_0

    .line 852
    const-string v1, "LGDBControl"

    const-string v2, " Cursor is null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 853
    const/4 v15, 0x0

    .line 933
    :goto_0
    return-object v15

    .line 855
    :cond_0
    invoke-interface {v12}, Landroid/database/Cursor;->moveToFirst()Z

    .line 856
    invoke-interface {v12}, Landroid/database/Cursor;->getCount()I

    move-result v8

    .line 857
    .local v8, "count":I
    const-string v1, "LGDBControl"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "now in the db for "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " \'s count is "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 859
    move/from16 v0, p2

    if-gt v8, v0, :cond_1

    .line 861
    invoke-interface {v12}, Landroid/database/Cursor;->close()V

    .line 862
    const-string v15, "0"

    goto :goto_0

    .line 864
    :cond_1
    move/from16 v0, p2

    invoke-interface {v12, v0}, Landroid/database/Cursor;->move(I)Z

    .line 866
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->ID_INDEX:I

    invoke-interface {v12, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v11

    .line 867
    .local v11, "key":Ljava/lang/String;
    invoke-static {v11}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v14

    .line 868
    .local v14, "pos":I
    const-string v1, "LGDBControl"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "your pos"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 871
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    invoke-interface {v12, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "Dummy"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    invoke-interface {v12, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "dummy"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    :cond_2
    const/4 v1, 0x1

    move/from16 v0, p3

    if-ne v0, v1, :cond_3

    .line 873
    const-string v1, "LGDBControl"

    const-string v2, "[DATA] Dummy APN return 0"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 874
    const-string v15, "0"

    goto/16 :goto_0

    .line 878
    :cond_3
    const-string v13, "LTE|EHRPD"

    .line 879
    .local v13, "myBearer":Ljava/lang/String;
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->BEARER_INDEX:I

    invoke-interface {v12, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "14"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 881
    const-string v13, "LTE"

    .line 895
    :cond_4
    :goto_1
    const/4 v10, 0x0

    .line 896
    .local v10, "inactivityTime":I
    sget-object v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->mfeatureset:Ljava/lang/String;

    const-string v2, "SPCSBASE"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 898
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->INACTIVITETIMER_INDEX:I

    invoke-interface {v12, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v10

    .line 899
    const-string v1, "LGDBControl"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[bycho]inactivitytime "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 904
    :cond_5
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    invoke-interface {v12, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    move-object/from16 v0, p0

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LGDBControl;->getAPNType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 905
    .local v7, "apnType":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->APN_INDEX:I

    invoke-interface {v12, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->IP_INDEX:I

    invoke-interface {v12, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->AUTH_TYPE_INDEX:I

    invoke-interface {v12, v2}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->USER_INDEX:I

    invoke-interface {v12, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->PASSWORD_INDEX:I

    invoke-interface {v12, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->NAME_INDEX:I

    invoke-interface {v12, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    .line 921
    .local v15, "result":Ljava/lang/String;
    if-eqz p4, :cond_6

    .line 923
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSC_INDEX:I

    invoke-interface {v12, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSPROXY_INDEX:I

    invoke-interface {v12, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSPORT_INDEX:I

    invoke-interface {v12, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    .line 927
    const-string v1, "LGDBControl"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getting info is !! "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 931
    :cond_6
    const-string v1, "LGDBControl"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getting info is !! "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 932
    invoke-interface {v12}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 883
    .end local v7    # "apnType":Ljava/lang/String;
    .end local v10    # "inactivityTime":I
    .end local v15    # "result":Ljava/lang/String;
    :cond_7
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->BEARER_INDEX:I

    invoke-interface {v12, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "13"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 885
    const-string v13, "EHRPD"

    goto/16 :goto_1

    .line 888
    :cond_8
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->BEARER_INDEX:I

    invoke-interface {v12, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "3"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 890
    const-string v13, "GSM"

    goto/16 :goto_1
.end method

.method public getSpLTEApnFromDbSYSPROP(Landroid/content/Context;IZZ)Ljava/lang/String;
    .locals 19
    .param p1, "c"    # Landroid/content/Context;
    .param p2, "row"    # I
    .param p3, "dummy"    # Z
    .param p4, "restoreAPNorBackupAPN"    # Z

    .prologue
    .line 939
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v12

    .line 941
    .local v12, "cr":Landroid/content/ContentResolver;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "numeric=\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 945
    .local v4, "where":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    sget-object v3, Lcom/android/internal/telephony/lgdata/LGDBControl;->sProjection:[Ljava/lang/String;

    const/4 v5, 0x0

    const-string v6, "_id"

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v15

    .line 948
    .local v15, "mCursor":Landroid/database/Cursor;
    if-nez v15, :cond_0

    .line 950
    const-string v1, "LGDBControl"

    const-string v2, " Cursor is null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 951
    const/16 v18, 0x0

    .line 1031
    :goto_0
    return-object v18

    .line 953
    :cond_0
    invoke-interface {v15}, Landroid/database/Cursor;->moveToFirst()Z

    .line 954
    invoke-interface {v15}, Landroid/database/Cursor;->getCount()I

    move-result v11

    .line 955
    .local v11, "count":I
    const-string v1, "LGDBControl"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "now in the db for "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " \'s count is "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 957
    move/from16 v0, p2

    if-gt v11, v0, :cond_1

    .line 959
    invoke-interface {v15}, Landroid/database/Cursor;->close()V

    .line 960
    const-string v18, "0"

    goto :goto_0

    .line 962
    :cond_1
    move/from16 v0, p2

    invoke-interface {v15, v0}, Landroid/database/Cursor;->move(I)Z

    .line 964
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->ID_INDEX:I

    invoke-interface {v15, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v14

    .line 965
    .local v14, "key":Ljava/lang/String;
    invoke-static {v14}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v17

    .line 966
    .local v17, "pos":I
    const-string v1, "LGDBControl"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "your pos"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, v17

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 968
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    invoke-interface {v15, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "Dummy"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    invoke-interface {v15, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "dummy"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    :cond_2
    const/4 v1, 0x1

    move/from16 v0, p3

    if-ne v0, v1, :cond_3

    .line 970
    const-string v1, "LGDBControl"

    const-string v2, "[DATA] Dummy APN return 0"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 971
    const-string v18, "0"

    goto/16 :goto_0

    .line 974
    :cond_3
    const-string v16, "LTE|EHRPD"

    .line 975
    .local v16, "myBearer":Ljava/lang/String;
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->BEARER_INDEX:I

    invoke-interface {v15, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "14"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 977
    const-string v16, "LTE"

    .line 988
    :cond_4
    :goto_1
    const/4 v13, 0x0

    .line 989
    .local v13, "inactivityTime":I
    sget-object v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->mfeatureset:Ljava/lang/String;

    const-string v2, "SPCSBASE"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 991
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->INACTIVITETIMER_INDEX:I

    invoke-interface {v15, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v13

    .line 992
    const-string v1, "LGDBControl"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[bycho]inactivitytime "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 995
    :cond_5
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    invoke-interface {v15, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    move-object/from16 v0, p0

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LGDBControl;->getAPNType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 996
    .local v8, "apnType":Ljava/lang/String;
    move-object v10, v8

    .line 999
    .local v10, "convApnType":Ljava/lang/String;
    const-string v1, "default"

    invoke-virtual {v8, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_a

    .line 1000
    const-string v10, "internet"

    .line 1007
    :cond_6
    :goto_2
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->IP_INDEX:I

    invoke-interface {v15, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v7

    .line 1009
    .local v7, "apnProtocol":Ljava/lang/String;
    move-object v9, v7

    .line 1010
    .local v9, "convApnProtocol":Ljava/lang/String;
    const-string v1, "IPV4V6"

    invoke-virtual {v7, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_c

    .line 1011
    const-string v9, "IPv4v6"

    .line 1018
    :cond_7
    :goto_3
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "1,"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->APN_INDEX:I

    invoke-interface {v15, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v0, v16

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->AUTH_TYPE_INDEX:I

    invoke-interface {v15, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->USER_INDEX:I

    invoke-interface {v15, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->PASSWORD_INDEX:I

    invoke-interface {v15, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    .line 1029
    .local v18, "result":Ljava/lang/String;
    const-string v1, "LGDBControl"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getting info is !! "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, v18

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1030
    invoke-interface {v15}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 979
    .end local v7    # "apnProtocol":Ljava/lang/String;
    .end local v8    # "apnType":Ljava/lang/String;
    .end local v9    # "convApnProtocol":Ljava/lang/String;
    .end local v10    # "convApnType":Ljava/lang/String;
    .end local v13    # "inactivityTime":I
    .end local v18    # "result":Ljava/lang/String;
    :cond_8
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->BEARER_INDEX:I

    invoke-interface {v15, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "13"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_9

    .line 981
    const-string v16, "EHRPD"

    goto/16 :goto_1

    .line 983
    :cond_9
    sget v1, Lcom/android/internal/telephony/lgdata/LGDBControl;->BEARER_INDEX:I

    invoke-interface {v15, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "3"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 985
    const-string v16, "GSM"

    goto/16 :goto_1

    .line 1001
    .restart local v8    # "apnType":Ljava/lang/String;
    .restart local v10    # "convApnType":Ljava/lang/String;
    .restart local v13    # "inactivityTime":I
    :cond_a
    const-string v1, "dun"

    invoke-virtual {v8, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_b

    .line 1002
    const-string v10, "pam"

    goto/16 :goto_2

    .line 1003
    :cond_b
    const-string v1, "fota"

    invoke-virtual {v8, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 1004
    const-string v10, "ota"

    goto/16 :goto_2

    .line 1012
    .restart local v7    # "apnProtocol":Ljava/lang/String;
    .restart local v9    # "convApnProtocol":Ljava/lang/String;
    :cond_c
    const-string v1, "IP"

    invoke-virtual {v7, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_d

    .line 1013
    const-string v9, "IPv4"

    goto/16 :goto_3

    .line 1014
    :cond_d
    const-string v1, "IPV6"

    invoke-virtual {v7, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 1015
    const-string v9, "IPv6"

    goto/16 :goto_3
.end method

.method public isEqualApnType(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 6
    .param p1, "db"    # Ljava/lang/String;
    .param p2, "apnType"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 1397
    new-array v0, v3, [Ljava/lang/String;

    .line 1399
    .local v0, "apnTypeTemp":[Ljava/lang/String;
    if-eqz v0, :cond_3

    .line 1401
    const-string v4, ","

    invoke-virtual {p1, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 1403
    array-length v4, v0

    if-le v4, v2, :cond_2

    .line 1405
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v4, v0

    if-ge v1, v4, :cond_1

    .line 1407
    aget-object v4, v0, v1

    invoke-virtual {v4, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1409
    const-string v3, "LGDBControl"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "there are more than 1 type, isEqualApnType = true, found : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget-object v5, v0, v1

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1423
    .end local v1    # "i":I
    :goto_1
    return v2

    .line 1405
    .restart local v1    # "i":I
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    move v2, v3

    .line 1414
    goto :goto_1

    .line 1418
    .end local v1    # "i":I
    :cond_2
    const-string v2, "LGDBControl"

    const-string v3, "there is only 1 type"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1419
    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    goto :goto_1

    :cond_3
    move v2, v3

    .line 1423
    goto :goto_1
.end method

.method public makedummy()Z
    .locals 12

    .prologue
    const/4 v11, 0x5

    const/4 v10, 0x3

    const/4 v7, 0x0

    .line 246
    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    const-string v9, "phone"

    invoke-virtual {v8, v9}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/telephony/TelephonyManager;

    .line 248
    .local v2, "mTelephonyManager":Landroid/telephony/TelephonyManager;
    const-string v3, "0"

    .line 249
    .local v3, "mcc":Ljava/lang/String;
    const-string v4, "0"

    .line 251
    .local v4, "mnc":Ljava/lang/String;
    sget-object v8, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    if-eqz v8, :cond_0

    sget-object v8, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v8

    if-ge v8, v11, :cond_1

    .line 253
    :cond_0
    const-string v8, "LGDBControl"

    const-string v9, "[makedummy]home oper is bad. error "

    invoke-static {v8, v9}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 296
    :goto_0
    return v7

    .line 258
    :cond_1
    sget-object v8, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v1

    .line 260
    .local v1, "length":I
    if-ge v1, v11, :cond_2

    .line 262
    const-string v8, "LGDBControl"

    const-string v9, "[makedummy]home oper is bad. error, length<5 "

    invoke-static {v8, v9}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 266
    :cond_2
    sget-object v8, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v8, v7, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    .line 267
    sget-object v8, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v8, v10, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    .line 269
    new-instance v6, Landroid/content/ContentValues;

    invoke-direct {v6}, Landroid/content/ContentValues;-><init>()V

    .line 271
    .local v6, "values":Landroid/content/ContentValues;
    const-string v8, "type"

    const-string v9, "Dummy"

    invoke-virtual {v6, v8, v9}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 272
    const-string v8, "apn"

    const-string v9, "dummy"

    invoke-virtual {v6, v8, v9}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 273
    const-string v8, "protocol"

    const-string v9, "IPV4V6"

    invoke-virtual {v6, v8, v9}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 275
    const-string v8, "bearer"

    const-string v9, "0"

    invoke-virtual {v6, v8, v9}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 276
    const-string v8, "authtype"

    const-string v9, "0"

    invoke-virtual {v6, v8, v9}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 277
    const-string v8, "user"

    const-string v9, "ncc"

    invoke-virtual {v6, v8, v9}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 278
    const-string v8, "password"

    const-string v9, "ncc"

    invoke-virtual {v6, v8, v9}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 279
    const-string v8, "name"

    const-string v9, "none"

    invoke-virtual {v6, v8, v9}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 280
    const-string v8, "mcc"

    invoke-virtual {v6, v8, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 281
    const-string v8, "mnc"

    invoke-virtual {v6, v8, v4}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 282
    const-string v8, "numeric"

    sget-object v9, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v6, v8, v9}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 285
    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {v8}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 286
    .local v0, "cr":Landroid/content/ContentResolver;
    sget-object v8, Lcom/android/internal/telephony/lgdata/LGDBControl;->mUri:Landroid/net/Uri;

    invoke-virtual {v0, v8, v6}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v5

    .line 288
    .local v5, "result":Landroid/net/Uri;
    if-nez v5, :cond_3

    .line 290
    const-string v8, "LGDBControl"

    const-string v9, "make dummy fail"

    invoke-static {v8, v9}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 295
    :cond_3
    const-string v7, "LGDBControl"

    const-string v8, "make dummy success"

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 296
    const/4 v7, 0x1

    goto/16 :goto_0
.end method

.method public restoreAPNs()V
    .locals 9

    .prologue
    .line 739
    const/4 v6, 0x0

    new-array v5, v6, [Ljava/lang/String;

    .line 743
    .local v5, "intiDBs":[Ljava/lang/String;
    :try_start_0
    new-instance v4, Ljava/io/BufferedReader;

    new-instance v6, Ljava/io/FileReader;

    const-string v7, "/persist-lg/LGE_RC/apn_backup"

    invoke-direct {v6, v7}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v4, v6}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 746
    .local v4, "inApnFile":Ljava/io/BufferedReader;
    invoke-virtual {v4}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v0

    .line 747
    .local v0, "buffer":Ljava/lang/String;
    const-string v6, "LGDBControl"

    const-string v7, "!!!!![restoreAPNs]LGFactoryReset"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 749
    if-eqz v0, :cond_2

    .line 751
    const-string v6, "LGDBControl"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "!!!!![restoreAPNs]LGFactoryReset buffer :"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 752
    const-string v6, " "

    invoke-virtual {v0, v6}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    .line 753
    const-string v6, "LGDBControl"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "!!!!!LGFactoryReset intiDBs.length : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    array-length v8, v5

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 755
    array-length v6, v5

    if-lez v6, :cond_1

    .line 757
    const/4 v3, 0x1

    .local v3, "i":I
    :goto_0
    array-length v6, v5

    if-ge v3, v6, :cond_0

    .line 759
    add-int/lit8 v6, v3, -0x1

    aget-object v7, v5, v3

    const/4 v8, 0x1

    invoke-virtual {p0, v6, v7, v8}, Lcom/android/internal/telephony/lgdata/LGDBControl;->setAPNString(ILjava/lang/String;Z)Z

    .line 757
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 761
    :cond_0
    const-string v6, "LGDBControl"

    const-string v7, "!!!!!LGFactoryReset: Restore APN table!"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 772
    .end local v3    # "i":I
    :goto_1
    invoke-virtual {v4}, Ljava/io/BufferedReader;->close()V

    .line 774
    new-instance v2, Ljava/io/File;

    const-string v6, "/persist-lg/LGE_RC/apn_backup"

    invoke-direct {v2, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 775
    .local v2, "f":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    .line 777
    sget-object v6, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/lgdata/LGDBControl;->setMMSType(Ljava/lang/String;)V

    .line 784
    .end local v0    # "buffer":Ljava/lang/String;
    .end local v2    # "f":Ljava/io/File;
    .end local v4    # "inApnFile":Ljava/io/BufferedReader;
    :goto_2
    return-void

    .line 765
    .restart local v0    # "buffer":Ljava/lang/String;
    .restart local v4    # "inApnFile":Ljava/io/BufferedReader;
    :cond_1
    const-string v6, "LGDBControl"

    const-string v7, "!!!!!!No Backup APNs apn num 0 "

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 780
    .end local v0    # "buffer":Ljava/lang/String;
    .end local v4    # "inApnFile":Ljava/io/BufferedReader;
    :catch_0
    move-exception v1

    .line 782
    .local v1, "e":Ljava/lang/Exception;
    const-string v6, "LGDBControl"

    const-string v7, "!!!!!!No Backup APNs: Do not need to apn backup"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    .line 770
    .end local v1    # "e":Ljava/lang/Exception;
    .restart local v0    # "buffer":Ljava/lang/String;
    .restart local v4    # "inApnFile":Ljava/io/BufferedReader;
    :cond_2
    :try_start_1
    const-string v6, "LGDBControl"

    const-string v7, "buffer is NULL"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method

.method public restoreAPNs(Ljava/lang/String;)V
    .locals 9
    .param p1, "filename"    # Ljava/lang/String;

    .prologue
    .line 788
    const/4 v6, 0x0

    new-array v4, v6, [Ljava/lang/String;

    .line 789
    .local v4, "intiDBs":[Ljava/lang/String;
    const-string v5, "/persist-lg/LGE_RC/"

    .line 790
    .local v5, "mFilePath":Ljava/lang/String;
    if-eqz p1, :cond_1

    .line 794
    :try_start_0
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 795
    new-instance v3, Ljava/io/BufferedReader;

    new-instance v6, Ljava/io/FileReader;

    invoke-direct {v6, v5}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v3, v6}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 798
    .local v3, "inApnFile":Ljava/io/BufferedReader;
    invoke-virtual {v3}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v0

    .line 799
    .local v0, "buffer":Ljava/lang/String;
    const-string v6, "LGDBControl"

    const-string v7, "!!!!![restoreAPNs]LGFactoryReset"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 801
    if-eqz v0, :cond_3

    .line 803
    const-string v6, "LGDBControl"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " !!!!![restoreAPNs]LGFactoryReset buffer :"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 804
    const-string v6, " "

    invoke-virtual {v0, v6}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .line 805
    const-string v6, "LGDBControl"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "!!!!!LGFactoryReset intiDBs.length : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    array-length v8, v4

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 807
    array-length v6, v4

    if-lez v6, :cond_2

    .line 809
    const/4 v2, 0x1

    .local v2, "i":I
    :goto_0
    array-length v6, v4

    if-ge v2, v6, :cond_0

    .line 811
    add-int/lit8 v6, v2, -0x1

    aget-object v7, v4, v2

    const/4 v8, 0x1

    invoke-virtual {p0, v6, v7, v8}, Lcom/android/internal/telephony/lgdata/LGDBControl;->setAPNString(ILjava/lang/String;Z)Z

    .line 809
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 813
    :cond_0
    const-string v6, "LGDBControl"

    const-string v7, "!!!!!LGFactoryReset: Restore APN table!"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 824
    .end local v2    # "i":I
    :goto_1
    invoke-virtual {v3}, Ljava/io/BufferedReader;->close()V

    .line 827
    sget-object v6, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/lgdata/LGDBControl;->setMMSType(Ljava/lang/String;)V

    .line 835
    .end local v0    # "buffer":Ljava/lang/String;
    .end local v3    # "inApnFile":Ljava/io/BufferedReader;
    :cond_1
    :goto_2
    return-void

    .line 817
    .restart local v0    # "buffer":Ljava/lang/String;
    .restart local v3    # "inApnFile":Ljava/io/BufferedReader;
    :cond_2
    const-string v6, "LGDBControl"

    const-string v7, "!!!!!!No Backup APNs apn num 0 "

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 830
    .end local v0    # "buffer":Ljava/lang/String;
    .end local v3    # "inApnFile":Ljava/io/BufferedReader;
    :catch_0
    move-exception v1

    .line 832
    .local v1, "e":Ljava/lang/Exception;
    const-string v6, "LGDBControl"

    const-string v7, "!!!!!!No Backup APNs: Do not need to apn backup"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    .line 822
    .end local v1    # "e":Ljava/lang/Exception;
    .restart local v0    # "buffer":Ljava/lang/String;
    .restart local v3    # "inApnFile":Ljava/io/BufferedReader;
    :cond_3
    :try_start_1
    const-string v6, "LGDBControl"

    const-string v7, "buffer is NULL"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method

.method public setAPNString(ILjava/lang/String;)Z
    .locals 4
    .param p1, "id"    # I
    .param p2, "s"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 188
    const-string v1, "LGDBControl"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "!!! set APN Called "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 189
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/lgdata/LGDBControl;->checkId(I)Z

    move-result v1

    if-nez v1, :cond_0

    .line 191
    const-string v1, "LGDBControl"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "!!! set APN Called "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "return false "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 195
    :goto_0
    return v0

    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {p0, v1, p2, p1, v0}, Lcom/android/internal/telephony/lgdata/LGDBControl;->updateApnDB(Landroid/content/Context;Ljava/lang/String;IZ)Z

    move-result v0

    goto :goto_0
.end method

.method public setAPNString(ILjava/lang/String;Z)Z
    .locals 3
    .param p1, "id"    # I
    .param p2, "s"    # Ljava/lang/String;
    .param p3, "restoreAPNorBackupAPN"    # Z

    .prologue
    .line 200
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!!! set APN Called "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 201
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!!! set APN Called restoreAPNorBackupApn is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 202
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/lgdata/LGDBControl;->checkId(I)Z

    move-result v0

    if-nez v0, :cond_0

    .line 204
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!!! set APN Called "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "return false "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 205
    const/4 v0, 0x0

    .line 208
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {p0, v0, p2, p1, p3}, Lcom/android/internal/telephony/lgdata/LGDBControl;->updateApnDB(Landroid/content/Context;Ljava/lang/String;IZ)Z

    move-result v0

    goto :goto_0
.end method

.method public setApnValues(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 4
    .param p1, "type"    # Ljava/lang/String;
    .param p2, "item"    # Ljava/lang/String;
    .param p3, "values"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 1355
    const/4 v0, 0x0

    .line 1357
    .local v0, "result":Z
    if-nez p3, :cond_1

    .line 1358
    const-string v2, "LGDBControl"

    const-string v3, "Return false because values is null"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1391
    :cond_0
    :goto_0
    return v1

    .line 1362
    :cond_1
    const-string v2, "apn"

    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "carrier_enabled"

    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "maxconn"

    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "maxconn_t"

    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "wait_time"

    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 1368
    :cond_2
    invoke-direct {p0, p1, p2, p3}, Lcom/android/internal/telephony/lgdata/LGDBControl;->updateApnValues(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    .line 1369
    const-string v1, "LGDBControl"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setApn type : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " column is : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " values is : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " result is : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v1, v0

    .line 1370
    goto :goto_0

    .line 1372
    :cond_3
    const-string v2, "protocol"

    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1374
    if-eqz p3, :cond_4

    .line 1375
    const-string v1, "IPv4"

    invoke-virtual {p3, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 1376
    const-string p3, "IP"

    .line 1386
    :cond_4
    :goto_1
    invoke-direct {p0, p1, p2, p3}, Lcom/android/internal/telephony/lgdata/LGDBControl;->updateApnValues(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    .line 1387
    const-string v1, "LGDBControl"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setApn type : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " column is : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " result is : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v1, v0

    .line 1388
    goto/16 :goto_0

    .line 1377
    :cond_5
    const-string v1, "IPv6"

    invoke-virtual {p3, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 1378
    const-string p3, "IPV6"

    goto :goto_1

    .line 1379
    :cond_6
    const-string v1, "IPv4 and IPv6"

    invoke-virtual {p3, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_7

    const-string v1, "IPv4v6"

    invoke-virtual {p3, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 1380
    :cond_7
    const-string p3, "IPV4V6"

    goto :goto_1

    .line 1382
    :cond_8
    const-string p3, "IPV4V6"

    goto :goto_1
.end method

.method public setMMSInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 16
    .param p1, "numeric"    # Ljava/lang/String;
    .param p2, "MMSC"    # Ljava/lang/String;
    .param p3, "MMCProxy"    # Ljava/lang/String;
    .param p4, "MMSPort"    # Ljava/lang/String;

    .prologue
    .line 362
    new-instance v15, Landroid/content/ContentValues;

    invoke-direct {v15}, Landroid/content/ContentValues;-><init>()V

    .line 363
    .local v15, "values":Landroid/content/ContentValues;
    if-eqz p2, :cond_0

    .line 364
    const-string v2, "mmsc"

    move-object/from16 v0, p2

    invoke-virtual {v15, v2, v0}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 366
    :cond_0
    if-eqz p3, :cond_1

    .line 367
    const-string v2, "mmsproxy"

    move-object/from16 v0, p3

    invoke-virtual {v15, v2, v0}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 369
    :cond_1
    if-eqz p4, :cond_2

    .line 370
    const-string v2, "mmsport"

    move-object/from16 v0, p4

    invoke-virtual {v15, v2, v0}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 374
    :cond_2
    const/4 v13, 0x0

    .line 376
    .local v13, "retrunval":Z
    const-string v5, "type LIKE \'%default%\' OR type LIKE \'%mms%\'"

    .line 378
    .local v5, "where":Ljava/lang/String;
    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->mfeatureset:Ljava/lang/String;

    const-string v3, "VZWBASE"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 379
    const-string v5, "type LIKE \'%mms%\'"

    .line 381
    :cond_3
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    sget-object v3, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    sget-object v4, Lcom/android/internal/telephony/lgdata/LGDBControl;->sProjection:[Ljava/lang/String;

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-virtual/range {v2 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v10

    .line 386
    .local v10, "mCursor":Landroid/database/Cursor;
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "setMMSInfo where is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 387
    if-eqz v10, :cond_7

    invoke-interface {v10}, Landroid/database/Cursor;->getCount()I

    move-result v2

    if-lez v2, :cond_7

    .line 388
    invoke-interface {v10}, Landroid/database/Cursor;->getCount()I

    move-result v12

    .line 389
    .local v12, "recordCount":I
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "setMMSInfo recordCount "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 390
    invoke-interface {v10}, Landroid/database/Cursor;->moveToFirst()Z

    .line 391
    :goto_0
    invoke-interface {v10}, Landroid/database/Cursor;->isAfterLast()Z

    move-result v2

    if-nez v2, :cond_6

    .line 392
    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->NUMERIC_INDEX:I

    invoke-interface {v10, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v8

    .line 393
    .local v8, "dbNumeric":Ljava/lang/String;
    move-object/from16 v0, p1

    invoke-virtual {v8, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 394
    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSC_INDEX:I

    invoke-interface {v10, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    move-object/from16 v0, p2

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSPROXY_INDEX:I

    invoke-interface {v10, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    move-object/from16 v0, p3

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->MMSPORT_INDEX:I

    invoke-interface {v10, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    move-object/from16 v0, p4

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 396
    const-string v2, "LGDBControl"

    const-string v3, "setMMSInfo no change"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 406
    :cond_4
    :goto_1
    invoke-interface {v10}, Landroid/database/Cursor;->moveToNext()Z

    goto :goto_0

    .line 398
    :cond_5
    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->ID_INDEX:I

    invoke-interface {v10, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v9

    .line 399
    .local v9, "key":Ljava/lang/String;
    invoke-static {v9}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v11

    .line 400
    .local v11, "pos":I
    sget-object v2, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    int-to-long v6, v11

    invoke-static {v2, v6, v7}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;

    move-result-object v14

    .line 401
    .local v14, "url":Landroid/net/Uri;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v2, v14, v15, v3, v4}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    .line 402
    const/4 v13, 0x1

    .line 403
    const-string v2, "LGDBControl"

    const-string v3, "setMMSInfo update apn"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 408
    .end local v8    # "dbNumeric":Ljava/lang/String;
    .end local v9    # "key":Ljava/lang/String;
    .end local v11    # "pos":I
    .end local v14    # "url":Landroid/net/Uri;
    :cond_6
    invoke-interface {v10}, Landroid/database/Cursor;->close()V

    .line 410
    .end local v12    # "recordCount":I
    :cond_7
    return v13
.end method

.method public setMMSType(Ljava/lang/String;)V
    .locals 17
    .param p1, "numeric"    # Ljava/lang/String;

    .prologue
    .line 315
    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->mfeatureset:Ljava/lang/String;

    const-string v3, "SPCSBASE"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 316
    const-string v2, "LGDBControl"

    const-string v3, "setMMSType isMMSType only work SPCSBASE TODO...temp"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 360
    :cond_0
    :goto_0
    return-void

    .line 320
    :cond_1
    new-instance v16, Landroid/content/ContentValues;

    invoke-direct/range {v16 .. v16}, Landroid/content/ContentValues;-><init>()V

    .line 323
    .local v16, "values":Landroid/content/ContentValues;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "numeric =\'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, p1

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\' AND type LIKE \'%default%\'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 325
    .local v5, "where":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    sget-object v3, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    sget-object v4, Lcom/android/internal/telephony/lgdata/LGDBControl;->sProjection:[Ljava/lang/String;

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-virtual/range {v2 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v13

    .line 330
    .local v13, "mCursor":Landroid/database/Cursor;
    if-eqz v13, :cond_0

    invoke-interface {v13}, Landroid/database/Cursor;->getCount()I

    move-result v2

    if-lez v2, :cond_0

    .line 331
    invoke-interface {v13}, Landroid/database/Cursor;->moveToFirst()Z

    .line 332
    :goto_1
    invoke-interface {v13}, Landroid/database/Cursor;->isAfterLast()Z

    move-result v2

    if-nez v2, :cond_5

    .line 333
    const/4 v11, 0x0

    .line 334
    .local v11, "isMMSType":Z
    const/4 v2, 0x0

    new-array v9, v2, [Ljava/lang/String;

    .line 335
    .local v9, "apnTypeTemp":[Ljava/lang/String;
    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->TYPE_INDEX:I

    invoke-interface {v13, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v8

    .line 336
    .local v8, "apnType":Ljava/lang/String;
    if-eqz v8, :cond_3

    .line 337
    const-string v2, ","

    invoke-virtual {v8, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v9

    .line 338
    const/4 v10, 0x0

    .local v10, "i":I
    :goto_2
    array-length v2, v9

    if-ge v10, v2, :cond_3

    .line 339
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "apnType :: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-object v4, v9, v10

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 340
    aget-object v2, v9, v10

    const-string v3, "mms"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 341
    const/4 v11, 0x1

    .line 338
    :cond_2
    add-int/lit8 v10, v10, 0x1

    goto :goto_2

    .line 345
    .end local v10    # "i":I
    :cond_3
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "setMMSType isMMSType :: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 346
    if-nez v11, :cond_4

    .line 347
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ",mms"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 348
    const-string v2, "type"

    move-object/from16 v0, v16

    invoke-virtual {v0, v2, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 349
    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->ID_INDEX:I

    invoke-interface {v13, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v12

    .line 350
    .local v12, "key":Ljava/lang/String;
    invoke-static {v12}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v14

    .line 351
    .local v14, "pos":I
    sget-object v2, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    int-to-long v6, v14

    invoke-static {v2, v6, v7}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;

    move-result-object v15

    .line 352
    .local v15, "url":Landroid/net/Uri;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object/from16 v0, v16

    invoke-virtual {v2, v15, v0, v3, v4}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    .line 353
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "setMMSType :: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 355
    .end local v12    # "key":Ljava/lang/String;
    .end local v14    # "pos":I
    .end local v15    # "url":Landroid/net/Uri;
    :cond_4
    invoke-interface {v13}, Landroid/database/Cursor;->moveToNext()Z

    goto/16 :goto_1

    .line 357
    .end local v8    # "apnType":Ljava/lang/String;
    .end local v9    # "apnTypeTemp":[Ljava/lang/String;
    .end local v11    # "isMMSType":Z
    :cond_5
    invoke-interface {v13}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1558
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 1559
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string v1, "LGDBControl"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1560
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public updateAPNString(ILjava/lang/String;)Z
    .locals 3
    .param p1, "id"    # I
    .param p2, "s"    # Ljava/lang/String;

    .prologue
    .line 1043
    const-string v0, "LGDBControl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!!! set APN Called "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1055
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LGDBControl;->mContext:Landroid/content/Context;

    invoke-static {v0, p2, p1}, Lcom/android/internal/telephony/lgdata/LGDBControl;->updateApnDBForVZW(Landroid/content/Context;Ljava/lang/String;I)Z

    move-result v0

    return v0
.end method

.method public updateApnDB(Landroid/content/Context;Ljava/lang/String;IZ)Z
    .locals 21
    .param p1, "c"    # Landroid/content/Context;
    .param p2, "s"    # Ljava/lang/String;
    .param p3, "Set_id"    # I
    .param p4, "restoreAPNorBackupAPN"    # Z

    .prologue
    .line 443
    const-string v2, "phone"

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Landroid/telephony/TelephonyManager;

    .line 445
    .local v13, "mTelephonyManager":Landroid/telephony/TelephonyManager;
    const-string v2, ","

    move-object/from16 v0, p2

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v16

    .line 447
    .local v16, "parm":[Ljava/lang/String;
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "parm length = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, v16

    array-length v4, v0

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 449
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_0
    move-object/from16 v0, v16

    array-length v2, v0

    if-ge v9, v2, :cond_0

    .line 451
    const-string v2, "LGDBControl"

    aget-object v3, v16, v9

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 449
    add-int/lit8 v9, v9, 0x1

    goto :goto_0

    .line 454
    :cond_0
    const-string v14, "0"

    .line 455
    .local v14, "mcc":Ljava/lang/String;
    const-string v15, "0"

    .line 457
    .local v15, "mnc":Ljava/lang/String;
    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    if-eqz v2, :cond_1

    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x5

    if-ge v2, v3, :cond_2

    .line 459
    :cond_1
    const-string v2, "LGDBControl"

    const-string v3, "[updateApnDBupdateApnDB]home oper is bad. error "

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 460
    const/4 v2, 0x0

    .line 656
    :goto_1
    return v2

    .line 463
    :cond_2
    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v11

    .line 465
    .local v11, "length":I
    const/4 v2, 0x5

    if-ge v11, v2, :cond_3

    .line 467
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "home oper is bad. error "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 468
    const/4 v2, 0x0

    goto :goto_1

    .line 471
    :cond_3
    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    const/4 v3, 0x0

    const/4 v4, 0x3

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v14

    .line 472
    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    const/4 v3, 0x3

    invoke-virtual {v2, v3, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v15

    .line 474
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SIM Info reading Success "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ","

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 480
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "numeric=\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 484
    .local v5, "where":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    sget-object v3, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    sget-object v4, Lcom/android/internal/telephony/lgdata/LGDBControl;->sProjection:[Ljava/lang/String;

    const/4 v6, 0x0

    const-string v7, "_id"

    invoke-virtual/range {v2 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v12

    .line 487
    .local v12, "mCursor":Landroid/database/Cursor;
    if-nez v12, :cond_4

    .line 489
    const-string v2, "LGDBControl"

    const-string v3, " Cursor is null"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 490
    const/4 v2, 0x0

    goto/16 :goto_1

    .line 493
    :cond_4
    invoke-interface {v12}, Landroid/database/Cursor;->moveToFirst()Z

    .line 494
    invoke-interface {v12}, Landroid/database/Cursor;->getCount()I

    move-result v8

    .line 497
    .local v8, "count":I
    move/from16 v0, p3

    if-ge v8, v0, :cond_5

    .line 499
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "set id is bad id : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, p3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 500
    invoke-interface {v12}, Landroid/database/Cursor;->close()V

    .line 501
    const/4 v2, 0x0

    goto/16 :goto_1

    .line 504
    :cond_5
    move/from16 v0, p3

    invoke-interface {v12, v0}, Landroid/database/Cursor;->move(I)Z

    .line 506
    sget v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->ID_INDEX:I

    invoke-interface {v12, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v10

    .line 507
    .local v10, "key":Ljava/lang/String;
    invoke-static {v10}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v17

    .line 508
    .local v17, "pos":I
    sget-object v2, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    move/from16 v0, v17

    int-to-long v6, v0

    invoke-static {v2, v6, v7}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;

    move-result-object v19

    .line 510
    .local v19, "url":Landroid/net/Uri;
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "numeric : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 511
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "your pos "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, v17

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 514
    new-instance v20, Landroid/content/ContentValues;

    invoke-direct/range {v20 .. v20}, Landroid/content/ContentValues;-><init>()V

    .line 515
    .local v20, "values":Landroid/content/ContentValues;
    const/4 v2, 0x0

    aget-object v2, v16, v2

    const-string v3, "1"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_18

    .line 517
    const-string v2, "LGDBControl"

    const-string v3, "[updateApnDB]parm[0].equals(1)"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 518
    const/4 v2, 0x1

    aget-object v2, v16, v2

    const-string v3, "ota"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    .line 520
    const-string v2, "type"

    const-string v3, "fota"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 521
    const-string v2, "LGDBControl"

    const-string v3, "Telephony.Carriers.TYPE:: ota ->fota  "

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 538
    :goto_2
    const-string v2, "apn"

    const/4 v3, 0x2

    aget-object v3, v16, v3

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 541
    const/4 v2, 0x3

    aget-object v2, v16, v2

    const-string v3, "IPV4V6"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_c

    .line 543
    const-string v2, "protocol"

    const-string v3, "IPV4V6"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 559
    :goto_3
    const/4 v2, 0x5

    aget-object v2, v16, v2

    const-string v3, "LTE"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_10

    .line 561
    const-string v2, "bearer"

    const-string v3, "14"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 577
    :goto_4
    sget-object v2, Lcom/android/internal/telephony/lgdata/LGDBControl;->mfeatureset:Ljava/lang/String;

    const-string v3, "SPCSBASE"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 579
    const-string v2, "inactivetimer"

    const/4 v3, 0x4

    aget-object v3, v16, v3

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 584
    :cond_6
    if-eqz p4, :cond_7

    .line 585
    move-object/from16 v0, v16

    array-length v2, v0

    const/16 v3, 0xc

    if-le v2, v3, :cond_7

    .line 586
    const-string v2, "mmsc"

    const/16 v3, 0xa

    aget-object v3, v16, v3

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 587
    const-string v2, "mmsproxy"

    const/16 v3, 0xb

    aget-object v3, v16, v3

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 588
    const-string v2, "mmsport"

    const/16 v3, 0xc

    aget-object v3, v16, v3

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 589
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "MMS backup MMSC "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0xa

    aget-object v4, v16, v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 590
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "MMS backup MMSPROXY "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0xb

    aget-object v4, v16, v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 591
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "MMS backup MMSPORT "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0xc

    aget-object v4, v16, v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 600
    :cond_7
    const/4 v2, 0x6

    aget-object v2, v16, v2

    if-eqz v2, :cond_8

    const/4 v2, 0x6

    aget-object v2, v16, v2

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_13

    .line 601
    :cond_8
    const-string v2, "LGDBControl"

    const-string v3, "AUTH TYPE is null or empty, set Default:none"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 602
    const-string v2, "authtype"

    const-string v3, "0"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 619
    :goto_5
    const-string v2, "user"

    const/4 v3, 0x7

    aget-object v3, v16, v3

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 620
    const-string v2, "password"

    const/16 v3, 0x8

    aget-object v3, v16, v3

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 621
    const-string v2, "name"

    const/4 v3, 0x1

    aget-object v3, v16, v3

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 622
    const-string v2, "mcc"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v14}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 623
    const-string v2, "mnc"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v15}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 624
    const-string v2, "numeric"

    sget-object v3, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 652
    :goto_6
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object/from16 v0, v19

    move-object/from16 v1, v20

    invoke-virtual {v2, v0, v1, v3, v4}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v18

    .line 654
    .local v18, "result":I
    const-string v2, "LGDBControl"

    const-string v3, "updata success : "

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 655
    invoke-interface {v12}, Landroid/database/Cursor;->close()V

    .line 656
    const/4 v2, 0x1

    goto/16 :goto_1

    .line 523
    .end local v18    # "result":I
    :cond_9
    const/4 v2, 0x1

    aget-object v2, v16, v2

    const-string v3, "internet"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_a

    .line 525
    const-string v2, "type"

    const-string v3, "default"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 526
    const-string v2, "LGDBControl"

    const-string v3, "Telephony.Carriers.TYPE:: internet ->default  "

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_2

    .line 528
    :cond_a
    const/4 v2, 0x1

    aget-object v2, v16, v2

    const-string v3, "pam"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_b

    .line 530
    const-string v2, "type"

    const-string v3, "dun"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 531
    const-string v2, "LGDBControl"

    const-string v3, "Telephony.Carriers.TYPE:: pam ->dun"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_2

    .line 535
    :cond_b
    const-string v2, "type"

    const/4 v3, 0x1

    aget-object v3, v16, v3

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_2

    .line 545
    :cond_c
    const/4 v2, 0x3

    aget-object v2, v16, v2

    const-string v3, "IPV4"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_d

    const/4 v2, 0x3

    aget-object v2, v16, v2

    const-string v3, "IP"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_e

    .line 547
    :cond_d
    const-string v2, "protocol"

    const-string v3, "IP"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    .line 549
    :cond_e
    const/4 v2, 0x3

    aget-object v2, v16, v2

    const-string v3, "IPV6"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_f

    .line 551
    const-string v2, "protocol"

    const-string v3, "IPV6"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    .line 555
    :cond_f
    const-string v2, "protocol"

    const-string v3, "IPV4V6"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    .line 563
    :cond_10
    const/4 v2, 0x5

    aget-object v2, v16, v2

    const-string v3, "EHRPD"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_11

    .line 565
    const-string v2, "bearer"

    const-string v3, "13"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_4

    .line 567
    :cond_11
    const/4 v2, 0x5

    aget-object v2, v16, v2

    const-string v3, "GSM"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_12

    .line 569
    const-string v2, "bearer"

    const-string v3, "3"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_4

    .line 573
    :cond_12
    const-string v2, "bearer"

    const-string v3, "0"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_4

    .line 605
    :cond_13
    const/4 v2, 0x6

    aget-object v2, v16, v2

    const-string v3, "null"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_14

    .line 606
    const-string v2, "authtype"

    const-string v3, "0"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_5

    .line 607
    :cond_14
    const/4 v2, 0x6

    aget-object v2, v16, v2

    const-string v3, "pap"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_15

    .line 608
    const-string v2, "authtype"

    const-string v3, "1"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_5

    .line 609
    :cond_15
    const/4 v2, 0x6

    aget-object v2, v16, v2

    const-string v3, "chap"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_16

    .line 610
    const-string v2, "authtype"

    const-string v3, "2"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_5

    .line 611
    :cond_16
    const/4 v2, 0x6

    aget-object v2, v16, v2

    const-string v3, "pap|chap"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_17

    .line 612
    const-string v2, "authtype"

    const-string v3, "3"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_5

    .line 614
    :cond_17
    const-string v2, "LGDBControl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Invalid AUTH TYPE parameter "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/4 v4, 0x6

    aget-object v4, v16, v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ",set Deafualt:none "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 615
    const-string v2, "authtype"

    const-string v3, "0"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_5

    .line 626
    :cond_18
    const/4 v2, 0x0

    aget-object v2, v16, v2

    const-string v3, "0"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_19

    .line 628
    const-string v2, "LGDBControl"

    const-string v3, "[bycho,updateApnDB]parm[0].equals(0)"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 629
    const-string v2, "type"

    const-string v3, "Dummy"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 630
    const-string v2, "apn"

    const-string v3, "dummy"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 631
    const-string v2, "protocol"

    const-string v3, "IPV4V6"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 633
    const-string v2, "bearer"

    const-string v3, "0"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 634
    const-string v2, "authtype"

    const-string v3, "1"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 635
    const-string v2, "user"

    const-string v3, "ncc"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 636
    const-string v2, "password"

    const-string v3, "ncc"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 637
    const-string v2, "name"

    const-string v3, "none"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 638
    const-string v2, "mcc"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v14}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 639
    const-string v2, "mnc"

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v15}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 640
    const-string v2, "numeric"

    sget-object v3, Lcom/android/internal/telephony/lgdata/LGDBControl;->networkOperator:Ljava/lang/String;

    move-object/from16 v0, v20

    invoke-virtual {v0, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 642
    const-string v2, "LGDBControl"

    const-string v3, "delete success "

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_6

    .line 646
    :cond_19
    const-string v2, "LGDBControl"

    const-string v3, "[bycho,updateApnDB]parm[0] else"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 647
    invoke-interface {v12}, Landroid/database/Cursor;->close()V

    .line 648
    const/4 v2, 0x0

    goto/16 :goto_1
.end method
