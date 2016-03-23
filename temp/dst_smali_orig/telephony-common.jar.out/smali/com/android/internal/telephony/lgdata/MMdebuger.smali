.class public Lcom/android/internal/telephony/lgdata/MMdebuger;
.super Ljava/lang/Object;
.source "MMdebuger.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;,
        Lcom/android/internal/telephony/lgdata/MMdebuger$PDNLostHistory;,
        Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;
    }
.end annotation


# static fields
.field protected static final DEACTIVE_REQ:I = 0x3

.field protected static final DEACTIVE_RSP:I = 0x4

.field protected static final SETUP_REQ:I = 0x1

.field protected static final SETUP_RSP:I = 0x2


# instance fields
.field public LastConRadioTech:I

.field public LastPDNIPv:I

.field public LastPDNType:I

.field LteEmmErrorcode:I

.field c:Ljava/util/Calendar;

.field public currentAPNId:I

.field public currentRadioTech:I

.field lastfailreasion:[I

.field lastfailreasionOfInternetPND:[I

.field lastfailreasionOnEHRPD:[I

.field lastfailreasionOnLTE:[I

.field private mConHistory:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;",
            ">;"
        }
    .end annotation
.end field

.field public mLcurDay:I

.field public mLcurHour:I

.field public mLcurMinute:I

.field public mLcurMonth:I

.field public mLcurSecond:I

.field public mLcurYear:I

.field public mMaxSize:I

.field private mPDNFailHistory:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;",
            ">;"
        }
    .end annotation
.end field

.field private mPDNFailHistoryOnLTE:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;",
            ">;"
        }
    .end annotation
.end field

.field private mPDNFailHistoryonEHRPD:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;",
            ">;"
        }
    .end annotation
.end field

.field public mcurDay:I

.field public mcurHour:I

.field public mcurMinute:I

.field public mcurMonth:I

.field public mcurSecond:I

.field public mcurYear:I


# direct methods
.method public constructor <init>()V
    .locals 4

    .prologue
    const/4 v3, 0x4

    const/4 v2, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v1, 0x46

    iput v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mMaxSize:I

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mPDNFailHistory:Ljava/util/ArrayList;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mPDNFailHistoryOnLTE:Ljava/util/ArrayList;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mPDNFailHistoryonEHRPD:Ljava/util/ArrayList;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mConHistory:Ljava/util/ArrayList;

    new-array v1, v3, [I

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasion:[I

    new-array v1, v3, [I

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOfInternetPND:[I

    new-array v1, v3, [I

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOnLTE:[I

    new-array v1, v3, [I

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOnEHRPD:[I

    iput v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->LteEmmErrorcode:I

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v3, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasion:[I

    aput v2, v1, v0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOfInternetPND:[I

    aput v2, v1, v0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOnLTE:[I

    aput v2, v1, v0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOnEHRPD:[I

    aput v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method


# virtual methods
.method public CleanLastfailReasion()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOfInternetPND:[I

    aput v2, v0, v2

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOfInternetPND:[I

    const/4 v1, 0x1

    aput v2, v0, v1

    iput v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->LteEmmErrorcode:I

    return-void
.end method

.method public SetLteEmmErrorCode(I)V
    .locals 0
    .param p1, "ErrorCode"    # I

    .prologue
    iput p1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->LteEmmErrorcode:I

    return-void
.end method

.method public UpdateCurrentTime()V
    .locals 2

    .prologue
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurYear:I

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurMonth:I

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurDay:I

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    const/16 v1, 0xb

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurHour:I

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    const/16 v1, 0xc

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurMinute:I

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    const/16 v1, 0xd

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurSecond:I

    return-void
.end method

.method public UpdateLastCurrentTime()V
    .locals 2

    .prologue
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mLcurYear:I

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mLcurMonth:I

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mLcurDay:I

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    const/16 v1, 0xb

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mLcurHour:I

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    const/16 v1, 0xc

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mLcurMinute:I

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->c:Ljava/util/Calendar;

    const/16 v1, 0xd

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mLcurSecond:I

    return-void
.end method

.method public dstoint(Ljava/lang/String;)I
    .locals 2
    .param p1, "ds"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x2

    const-string v1, "fota"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 v0, 0x1

    :cond_0
    :goto_0
    return v0

    :cond_1
    const-string v1, "default"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "dun"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x3

    goto :goto_0
.end method

.method public getConnHistory(I)[I
    .locals 4
    .param p1, "itemnum"    # I

    .prologue
    const/16 v2, 0xb

    new-array v1, v2, [I

    .local v1, "returnvalue":[I
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mConHistory:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-gt v2, p1, :cond_0

    const/4 v1, 0x0

    .end local v1    # "returnvalue":[I
    :goto_0
    return-object v1

    .restart local v1    # "returnvalue":[I
    :cond_0
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mConHistory:Ljava/util/ArrayList;

    invoke-virtual {v2, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;

    .local v0, "binfo":Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;
    const/4 v2, 0x0

    iget v3, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->curYear:I

    aput v3, v1, v2

    const/4 v2, 0x1

    iget v3, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->curMonth:I

    aput v3, v1, v2

    const/4 v2, 0x2

    iget v3, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->curDay:I

    aput v3, v1, v2

    const/4 v2, 0x3

    iget v3, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->curHour:I

    aput v3, v1, v2

    const/4 v2, 0x4

    iget v3, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->curMinute:I

    aput v3, v1, v2

    const/4 v2, 0x5

    iget v3, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->curSecond:I

    aput v3, v1, v2

    const/4 v2, 0x6

    iget v3, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->cmdtype:I

    aput v3, v1, v2

    const/4 v2, 0x7

    iget v3, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->cid:I

    aput v3, v1, v2

    const/16 v2, 0x8

    iget v3, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->serialnum:I

    aput v3, v1, v2

    const/16 v2, 0x9

    iget v3, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->currRadioTech:I

    aput v3, v1, v2

    const/16 v2, 0xa

    iget v3, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->APNID:I

    aput v3, v1, v2

    goto :goto_0
.end method

.method public getLastFailreaon()[I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasion:[I

    return-object v0
.end method

.method public getLastFailreaonAtInternetPND()[I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOfInternetPND:[I

    return-object v0
.end method

.method public getLastFailreaonOnEHRPD()[I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOnEHRPD:[I

    return-object v0
.end method

.method public getLastFailreaonOnLTE()[I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOnLTE:[I

    return-object v0
.end method

.method public getLteEmmErrorcode()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->LteEmmErrorcode:I

    return v0
.end method

.method public getTimeoutHistory(I)[I
    .locals 1
    .param p1, "itemnum"    # I

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public saveAPNType(I)V
    .locals 0
    .param p1, "apnId"    # I

    .prologue
    iput p1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->currentAPNId:I

    return-void
.end method

.method public saveRspHistory(III)V
    .locals 8
    .param p1, "cmdtype"    # I
    .param p2, "Serial"    # I
    .param p3, "cid"    # I

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mConHistory:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mMaxSize:I

    if-lt v1, v2, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mConHistory:Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    :cond_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/MMdebuger;->UpdateCurrentTime()V

    new-instance v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;

    iget v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurYear:I

    iget v3, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurMonth:I

    iget v4, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurDay:I

    iget v5, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurHour:I

    iget v6, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurMinute:I

    iget v7, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurSecond:I

    move-object v1, p0

    invoke-direct/range {v0 .. v7}, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;-><init>(Lcom/android/internal/telephony/lgdata/MMdebuger;IIIIII)V

    .local v0, "binfo":Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;
    const/16 v1, 0x1b

    if-ne p1, v1, :cond_1

    const/4 v1, 0x2

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->cmdtype:I

    :goto_0
    iput p3, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->cid:I

    iput p2, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->serialnum:I

    iget v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->currentAPNId:I

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->APNID:I

    iget v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->currentRadioTech:I

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->currRadioTech:I

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mConHistory:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void

    :cond_1
    const/16 v1, 0x29

    if-ne p1, v1, :cond_2

    const/4 v1, 0x4

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->cmdtype:I

    goto :goto_0

    :cond_2
    const/16 v1, 0x63

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->cmdtype:I

    goto :goto_0
.end method

.method public saveUpHistory(I)V
    .locals 8
    .param p1, "Serial"    # I

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mConHistory:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mMaxSize:I

    if-lt v1, v2, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mConHistory:Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    :cond_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/MMdebuger;->UpdateCurrentTime()V

    new-instance v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;

    iget v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurYear:I

    iget v3, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurMonth:I

    iget v4, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurDay:I

    iget v5, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurHour:I

    iget v6, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurMinute:I

    iget v7, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurSecond:I

    move-object v1, p0

    invoke-direct/range {v0 .. v7}, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;-><init>(Lcom/android/internal/telephony/lgdata/MMdebuger;IIIIII)V

    .local v0, "binfo":Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;
    const/4 v1, 0x1

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->cmdtype:I

    const/4 v1, -0x1

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->cid:I

    iput p1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->serialnum:I

    iget v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->currentAPNId:I

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->APNID:I

    iget v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->currentRadioTech:I

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->currRadioTech:I

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mConHistory:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public savecurrenttech(I)V
    .locals 0
    .param p1, "newNetworkType"    # I

    .prologue
    iput p1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->currentRadioTech:I

    return-void
.end method

.method public savedownHistory(II)V
    .locals 8
    .param p1, "Serial"    # I
    .param p2, "cid"    # I

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mConHistory:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mMaxSize:I

    if-lt v1, v2, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mConHistory:Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    :cond_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/MMdebuger;->UpdateCurrentTime()V

    new-instance v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;

    iget v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurYear:I

    iget v3, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurMonth:I

    iget v4, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurDay:I

    iget v5, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurHour:I

    iget v6, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurMinute:I

    iget v7, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurSecond:I

    move-object v1, p0

    invoke-direct/range {v0 .. v7}, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;-><init>(Lcom/android/internal/telephony/lgdata/MMdebuger;IIIIII)V

    .local v0, "binfo":Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;
    const/4 v1, 0x3

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->cmdtype:I

    iput p2, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->cid:I

    iput p1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->serialnum:I

    iget v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->currentAPNId:I

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->APNID:I

    iget v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->currentRadioTech:I

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->currRadioTech:I

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mConHistory:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public setFailHistory(Ljava/lang/String;Ljava/lang/String;IIII)V
    .locals 8
    .param p1, "ds"    # Ljava/lang/String;
    .param p2, "ipv"    # Ljava/lang/String;
    .param p3, "currRadioTech"    # I
    .param p4, "reason"    # I
    .param p5, "reasonNum"    # I
    .param p6, "dy"    # I

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mPDNFailHistory:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mMaxSize:I

    if-lt v1, v2, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mPDNFailHistory:Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mPDNFailHistoryOnLTE:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mMaxSize:I

    if-lt v1, v2, :cond_1

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mPDNFailHistoryOnLTE:Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    :cond_1
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mPDNFailHistoryonEHRPD:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mMaxSize:I

    if-lt v1, v2, :cond_2

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mPDNFailHistoryonEHRPD:Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    :cond_2
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/MMdebuger;->UpdateCurrentTime()V

    new-instance v0, Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;

    iget v2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurYear:I

    iget v3, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurMonth:I

    iget v4, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurDay:I

    iget v5, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurHour:I

    iget v6, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurMinute:I

    iget v7, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mcurSecond:I

    move-object v1, p0

    invoke-direct/range {v0 .. v7}, Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;-><init>(Lcom/android/internal/telephony/lgdata/MMdebuger;IIIIII)V

    .local v0, "binfo":Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;
    if-nez p6, :cond_5

    const/16 v1, 0x63

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;->LastFailPDNType:I

    :goto_0
    iget v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;->LastFailPDNType:I

    packed-switch v1, :pswitch_data_0

    :goto_1
    const-string v1, "IP"

    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_6

    const/4 v1, 0x0

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;->LastFailPDNIPv:I

    :cond_3
    :goto_2
    iget v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->LastConRadioTech:I

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;->RequestRadioTech:I

    iput p3, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;->ResponseRadioTech:I

    iput p4, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;->reason:I

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mPDNFailHistory:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const/16 v1, 0xe

    if-ne p3, v1, :cond_8

    iget v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;->LastFailPDNType:I

    packed-switch v1, :pswitch_data_1

    :goto_3
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mPDNFailHistoryOnLTE:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_4
    :goto_4
    return-void

    :cond_5
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/lgdata/MMdebuger;->dstoint(Ljava/lang/String;)I

    move-result v1

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;->LastFailPDNType:I

    goto :goto_0

    :pswitch_0
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasion:[I

    const/4 v2, 0x0

    aput p5, v1, v2

    goto :goto_1

    :pswitch_1
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasion:[I

    const/4 v2, 0x1

    aput p5, v1, v2

    goto :goto_1

    :pswitch_2
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasion:[I

    const/4 v2, 0x2

    aput p5, v1, v2

    goto :goto_1

    :cond_6
    const-string v1, "IPV6"

    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    const/4 v1, 0x1

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;->LastFailPDNIPv:I

    goto :goto_2

    :cond_7
    const-string v1, "IPV4V6"

    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    const/4 v1, 0x2

    iput v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;->LastFailPDNIPv:I

    goto :goto_2

    :pswitch_3
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOnLTE:[I

    const/4 v2, 0x0

    aput p5, v1, v2

    goto :goto_3

    :pswitch_4
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOnLTE:[I

    const/4 v2, 0x1

    aput p5, v1, v2

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOfInternetPND:[I

    const/4 v2, 0x0

    aput p5, v1, v2

    goto :goto_3

    :pswitch_5
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOnLTE:[I

    const/4 v2, 0x2

    aput p5, v1, v2

    goto :goto_3

    :cond_8
    const/16 v1, 0xd

    if-ne p3, v1, :cond_4

    iget v1, v0, Lcom/android/internal/telephony/lgdata/MMdebuger$PDNFailHistory;->LastFailPDNType:I

    packed-switch v1, :pswitch_data_2

    :goto_5
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mPDNFailHistoryonEHRPD:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_4

    :pswitch_6
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOnEHRPD:[I

    const/4 v2, 0x0

    aput p5, v1, v2

    goto :goto_5

    :pswitch_7
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOnEHRPD:[I

    const/4 v2, 0x1

    aput p5, v1, v2

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOfInternetPND:[I

    const/4 v2, 0x1

    aput p5, v1, v2

    goto :goto_5

    :pswitch_8
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->lastfailreasionOnEHRPD:[I

    const/4 v2, 0x2

    aput p5, v1, v2

    goto :goto_5

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_3
        :pswitch_4
        :pswitch_5
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x1
        :pswitch_6
        :pswitch_7
        :pswitch_8
    .end packed-switch
.end method

.method public setMaxLogSize(I)V
    .locals 2
    .param p1, "maxnum"    # I

    .prologue
    const/16 v1, 0x1f4

    const/16 v0, 0xa

    iput p1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mMaxSize:I

    if-le p1, v1, :cond_1

    iput v1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mMaxSize:I

    :cond_0
    :goto_0
    return-void

    :cond_1
    if-ge p1, v0, :cond_0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/MMdebuger;->mMaxSize:I

    goto :goto_0
.end method

.method public setTimeoutHistory(IIIII)V
    .locals 0
    .param p1, "currRadioTech"    # I
    .param p2, "reqRadioTech"    # I
    .param p3, "reqSrvState"    # I
    .param p4, "CurrSrvState"    # I
    .param p5, "apnid"    # I

    .prologue
    return-void
.end method
