.class public Lcom/lge/uicc/framework/SimNodeHandlerSPR;
.super Ljava/lang/Object;
.source "SimNodeHandlerSPR.java"


# static fields
.field private static final OMADM_ICCID_NODE:Ljava/lang/String; = "OMADM_ICCID"

.field private static final OMADM_SIMLOCK_NODE:Ljava/lang/String; = "OMADM_SIMLOCK"

.field private static final PROJECTION:[Ljava/lang/String;

.field private static final SELECTION:Ljava/lang/String; = "key=?"

.field public static final SIM_LOCK:I = 0x12d

.field public static final SIM_UICCID:I = 0x12e


# instance fields
.field private mContext:Landroid/content/Context;

.field private mResolver:Landroid/content/ContentResolver;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "key"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "value"

    aput-object v2, v0, v1

    sput-object v0, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->PROJECTION:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "c"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->mContext:Landroid/content/Context;

    iget-object v0, p0, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->mResolver:Landroid/content/ContentResolver;

    return-void
.end method

.method private static logd(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[SimNodeHandlerSPR] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logd(Ljava/lang/String;)V

    return-void
.end method

.method private static loge(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[SimNodeHandlerSPR] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->loge(Ljava/lang/String;)V

    return-void
.end method

.method private static logp(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[SimNodeHandlerSPR] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logp(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public getNodeValue(I)Ljava/lang/String;
    .locals 10
    .param p1, "item"    # I

    .prologue
    const-string v0, "[CALL] getNodeValue"

    invoke-static {v0}, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->logd(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "item : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->logd(Ljava/lang/String;)V

    const/4 v8, 0x0

    .local v8, "result":Ljava/lang/String;
    const/4 v6, 0x0

    .local v6, "cursor":Landroid/database/Cursor;
    packed-switch p1, :pswitch_data_0

    :cond_0
    :goto_0
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Get SimNodeHandlerSPR result : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->logd(Ljava/lang/String;)V

    if-nez v8, :cond_1

    const-string v8, "0"

    :cond_1
    if-eqz v8, :cond_2

    const-string v0, ""

    invoke-virtual {v8, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v8, "0"
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_2
    if-eqz v6, :cond_3

    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    :cond_3
    :goto_1
    return-object v8

    :pswitch_0
    :try_start_1
    iget-object v0, p0, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->mResolver:Landroid/content/ContentResolver;

    sget-object v1, Lcom/lge/uicc/framework/NodeProviderSPR;->CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->PROJECTION:[Ljava/lang/String;

    const-string v3, "key=?"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/String;

    const/4 v5, 0x0

    const-string v9, "OMADM_SIMLOCK"

    aput-object v9, v4, v5

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    if-eqz v6, :cond_0

    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    invoke-interface {v6, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v8

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->mResolver:Landroid/content/ContentResolver;

    sget-object v1, Lcom/lge/uicc/framework/NodeProviderSPR;->CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->PROJECTION:[Ljava/lang/String;

    const-string v3, "key=?"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/String;

    const/4 v5, 0x0

    const-string v9, "OMADM_ICCID"

    aput-object v9, v4, v5

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    if-eqz v6, :cond_0

    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    invoke-interface {v6, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v8

    goto :goto_0

    :catch_0
    move-exception v7

    .local v7, "e":Ljava/lang/Exception;
    :try_start_2
    const-string v0, "Get SimNodeHandlerSPR result : Exception"

    invoke-static {v0}, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->logd(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-eqz v6, :cond_3

    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    goto :goto_1

    .end local v7    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v0

    if-eqz v6, :cond_4

    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    :cond_4
    throw v0

    nop

    :pswitch_data_0
    .packed-switch 0x12d
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public setNodeValue(ILjava/lang/String;)Z
    .locals 12
    .param p1, "item"    # I
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    const/4 v5, 0x0

    const/4 v11, 0x1

    const/4 v10, 0x0

    const-string v0, "[CALL] setNodeValue"

    invoke-static {v0}, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->logd(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "item : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->logd(Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "value : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->logd(Ljava/lang/String;)V

    const/4 v8, 0x0

    .local v8, "result":Z
    invoke-virtual {p2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p2

    new-instance v7, Landroid/content/ContentValues;

    invoke-direct {v7}, Landroid/content/ContentValues;-><init>()V

    .local v7, "cv":Landroid/content/ContentValues;
    const/4 v6, 0x0

    .local v6, "cursor":Landroid/database/Cursor;
    packed-switch p1, :pswitch_data_0

    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Set SimNodeHandlerSPR result : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->logd(Ljava/lang/String;)V

    return v8

    :pswitch_0
    iget-object v0, p0, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->mResolver:Landroid/content/ContentResolver;

    sget-object v1, Lcom/lge/uicc/framework/NodeProviderSPR;->CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->PROJECTION:[Ljava/lang/String;

    const-string v3, "key=?"

    new-array v4, v11, [Ljava/lang/String;

    const-string v9, "OMADM_SIMLOCK"

    aput-object v9, v4, v10

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    if-eqz v6, :cond_0

    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const-string v0, "key"

    const-string v1, "OMADM_SIMLOCK"

    invoke-virtual {v7, v0, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "value"

    invoke-virtual {v7, v0, p2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->mResolver:Landroid/content/ContentResolver;

    sget-object v1, Lcom/lge/uicc/framework/NodeProviderSPR;->CONTENT_URI:Landroid/net/Uri;

    invoke-virtual {v0, v1, v7}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    :goto_1
    const-string v0, "SIM_Lock property process SUCCESS !!!"

    invoke-static {v0}, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->logd(Ljava/lang/String;)V

    const/4 v8, 0x1

    goto :goto_0

    :cond_1
    const-string v0, "key"

    const-string v1, "OMADM_SIMLOCK"

    invoke-virtual {v7, v0, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "value"

    invoke-virtual {v7, v0, p2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->mResolver:Landroid/content/ContentResolver;

    sget-object v1, Lcom/lge/uicc/framework/NodeProviderSPR;->CONTENT_URI:Landroid/net/Uri;

    const-string v2, "key=?"

    new-array v3, v11, [Ljava/lang/String;

    const-string v4, "OMADM_SIMLOCK"

    aput-object v4, v3, v10

    invoke-virtual {v0, v1, v7, v2, v3}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    goto :goto_1

    :pswitch_1
    iget-object v0, p0, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->mResolver:Landroid/content/ContentResolver;

    sget-object v1, Lcom/lge/uicc/framework/NodeProviderSPR;->CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->PROJECTION:[Ljava/lang/String;

    const-string v3, "key=?"

    new-array v4, v11, [Ljava/lang/String;

    const-string v9, "OMADM_ICCID"

    aput-object v9, v4, v10

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    if-eqz v6, :cond_2

    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v0

    if-nez v0, :cond_3

    :cond_2
    const-string v0, "key"

    const-string v1, "OMADM_ICCID"

    invoke-virtual {v7, v0, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "value"

    invoke-virtual {v7, v0, p2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->mResolver:Landroid/content/ContentResolver;

    sget-object v1, Lcom/lge/uicc/framework/NodeProviderSPR;->CONTENT_URI:Landroid/net/Uri;

    invoke-virtual {v0, v1, v7}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    :goto_2
    const-string v0, "SIM_UICCID property process SUCCESS !!!"

    invoke-static {v0}, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->logd(Ljava/lang/String;)V

    const/4 v8, 0x1

    goto/16 :goto_0

    :cond_3
    const-string v0, "key"

    const-string v1, "OMADM_ICCID"

    invoke-virtual {v7, v0, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "value"

    invoke-virtual {v7, v0, p2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/uicc/framework/SimNodeHandlerSPR;->mResolver:Landroid/content/ContentResolver;

    sget-object v1, Lcom/lge/uicc/framework/NodeProviderSPR;->CONTENT_URI:Landroid/net/Uri;

    const-string v2, "key=?"

    new-array v3, v11, [Ljava/lang/String;

    const-string v4, "OMADM_ICCID"

    aput-object v4, v3, v10

    invoke-virtual {v0, v1, v7, v2, v3}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    goto :goto_2

    :pswitch_data_0
    .packed-switch 0x12d
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
