.class public final Lcom/vzw/nfc/AidFilter;
.super Ljava/lang/Object;
.source "AidFilter.java"


# static fields
.field private static mNfcAdapter:Lcom/lge/nfcaddon/INfcAdapterNxp;


# instance fields
.field public final DEFAULT_ROUTE_LOCATION:I


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "SecureElementType"

    const-string v1, "uicc"

    invoke-static {v0, v1}, Lcom/lge/nfcconfig/NfcConfigure;->IsNfcConfigureValue(Ljava/lang/String;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x2

    iput v0, p0, Lcom/vzw/nfc/AidFilter;->DEFAULT_ROUTE_LOCATION:I

    :goto_0
    return-void

    :cond_0
    const/4 v0, 0x1

    iput v0, p0, Lcom/vzw/nfc/AidFilter;->DEFAULT_ROUTE_LOCATION:I

    goto :goto_0
.end method

.method private getAid(Lcom/vzw/nfc/dos/AidRangeDo;Lcom/vzw/nfc/dos/AidMaskDo;)[B
    .locals 6
    .param p1, "aid_range"    # Lcom/vzw/nfc/dos/AidRangeDo;
    .param p2, "aid_mask"    # Lcom/vzw/nfc/dos/AidMaskDo;

    .prologue
    const/4 v5, 0x0

    const/4 v0, 0x0

    .local v0, "aid":[B
    invoke-virtual {p2}, Lcom/vzw/nfc/dos/AidMaskDo;->getAidMask()[B

    move-result-object v1

    .local v1, "barr_aid_mask":[B
    const/4 v2, 0x0

    .local v2, "count":I
    :goto_0
    array-length v3, v1

    if-ge v2, v3, :cond_0

    aget-byte v3, v1, v2

    const/4 v4, -0x1

    if-eq v3, v4, :cond_2

    :cond_0
    if-eqz v2, :cond_1

    new-array v0, v2, [B

    invoke-virtual {p1}, Lcom/vzw/nfc/dos/AidRangeDo;->getAidRange()[B

    move-result-object v3

    invoke-static {v3, v5, v0, v5, v2}, Ljava/lang/System;->arraycopy([BI[BII)V

    :cond_1
    return-object v0

    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method private getPowerState(Lcom/vzw/nfc/dos/FilterEntryDo;)I
    .locals 6
    .param p1, "filter_entry_do"    # Lcom/vzw/nfc/dos/FilterEntryDo;

    .prologue
    const/4 v1, 0x0

    .local v1, "powerState":I
    invoke-virtual {p1}, Lcom/vzw/nfc/dos/FilterEntryDo;->getRoutingModeDo()Lcom/vzw/nfc/dos/RoutingModeDo;

    move-result-object v3

    invoke-virtual {v3}, Lcom/vzw/nfc/dos/RoutingModeDo;->getRoutingInfo()B

    move-result v2

    .local v2, "routeInfo":I
    invoke-virtual {p1}, Lcom/vzw/nfc/dos/FilterEntryDo;->getFilterConditionTagDo()Lcom/vzw/nfc/dos/FilterConditionTagDo;

    move-result-object v0

    .local v0, "conditionTagDo":Lcom/vzw/nfc/dos/FilterConditionTagDo;
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/vzw/nfc/dos/FilterConditionTagDo;->getFilterConditionTag()B

    move-result v3

    const/16 v4, -0xf

    if-ne v3, v4, :cond_1

    const/4 v1, 0x1

    :cond_0
    :goto_0
    const-string v3, "AidFilter"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getPowerState"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return v1

    :cond_1
    if-eqz v2, :cond_0

    and-int/lit8 v3, v2, 0x2

    or-int/lit8 v3, v3, 0x4

    and-int/lit8 v4, v2, 0x4

    shr-int/lit8 v4, v4, 0x2

    or-int v1, v3, v4

    goto :goto_0
.end method

.method private static getServiceInterface()Lcom/lge/nfcaddon/INfcAdapterNxp;
    .locals 2

    .prologue
    sget-object v1, Lcom/vzw/nfc/AidFilter;->mNfcAdapter:Lcom/lge/nfcaddon/INfcAdapterNxp;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/vzw/nfc/AidFilter;->mNfcAdapter:Lcom/lge/nfcaddon/INfcAdapterNxp;

    .local v0, "b":Landroid/os/IBinder;
    :goto_0
    return-object v1

    .end local v0    # "b":Landroid/os/IBinder;
    :cond_0
    const-string v1, "nfcvendor"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .restart local v0    # "b":Landroid/os/IBinder;
    if-nez v0, :cond_1

    const/4 v1, 0x0

    goto :goto_0

    :cond_1
    invoke-static {v0}, Lcom/lge/nfcaddon/INfcAdapterNxp$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/nfcaddon/INfcAdapterNxp;

    move-result-object v1

    sput-object v1, Lcom/vzw/nfc/AidFilter;->mNfcAdapter:Lcom/lge/nfcaddon/INfcAdapterNxp;

    sget-object v1, Lcom/vzw/nfc/AidFilter;->mNfcAdapter:Lcom/lge/nfcaddon/INfcAdapterNxp;

    goto :goto_0
.end method

.method private prepareRouteInfo(Lcom/vzw/nfc/dos/ClfFilterDoList;Ljava/util/ArrayList;)V
    .locals 9
    .param p1, "all_CLF_FILTER_DO"    # Lcom/vzw/nfc/dos/ClfFilterDoList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/vzw/nfc/dos/ClfFilterDoList;",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/vzw/nfc/RouteEntry;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p2, "entries":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/vzw/nfc/RouteEntry;>;"
    invoke-virtual {p1}, Lcom/vzw/nfc/dos/ClfFilterDoList;->getClfFilterDos()Ljava/util/ArrayList;

    move-result-object v2

    .local v2, "clf_FILTER_DOs":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/vzw/nfc/dos/ClfFilterDo;>;"
    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    .local v4, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/vzw/nfc/dos/ClfFilterDo;

    .local v1, "clf_FILTER_DO":Lcom/vzw/nfc/dos/ClfFilterDo;
    invoke-virtual {v1}, Lcom/vzw/nfc/dos/ClfFilterDo;->getFilterEntryDo()Lcom/vzw/nfc/dos/FilterEntryDo;

    move-result-object v6

    invoke-virtual {v6}, Lcom/vzw/nfc/dos/FilterEntryDo;->getAidRangeDo()Lcom/vzw/nfc/dos/AidRangeDo;

    move-result-object v6

    invoke-virtual {v1}, Lcom/vzw/nfc/dos/ClfFilterDo;->getFilterEntryDo()Lcom/vzw/nfc/dos/FilterEntryDo;

    move-result-object v7

    invoke-virtual {v7}, Lcom/vzw/nfc/dos/FilterEntryDo;->getAidMaskDo()Lcom/vzw/nfc/dos/AidMaskDo;

    move-result-object v7

    invoke-direct {p0, v6, v7}, Lcom/vzw/nfc/AidFilter;->getAid(Lcom/vzw/nfc/dos/AidRangeDo;Lcom/vzw/nfc/dos/AidMaskDo;)[B

    move-result-object v0

    .local v0, "aid":[B
    invoke-virtual {v1}, Lcom/vzw/nfc/dos/ClfFilterDo;->getFilterEntryDo()Lcom/vzw/nfc/dos/FilterEntryDo;

    move-result-object v6

    invoke-direct {p0, v6}, Lcom/vzw/nfc/AidFilter;->getPowerState(Lcom/vzw/nfc/dos/FilterEntryDo;)I

    move-result v5

    .local v5, "powerState":I
    const-string v6, "AidFilter"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "prepareRouteInfo powerState"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v3, Lcom/vzw/nfc/RouteEntry;

    iget v6, p0, Lcom/vzw/nfc/AidFilter;->DEFAULT_ROUTE_LOCATION:I

    invoke-virtual {v1}, Lcom/vzw/nfc/dos/ClfFilterDo;->getFilterEntryDo()Lcom/vzw/nfc/dos/FilterEntryDo;

    move-result-object v7

    invoke-virtual {v7}, Lcom/vzw/nfc/dos/FilterEntryDo;->getVzwArDo()Lcom/vzw/nfc/dos/VzwPermissionDo;

    move-result-object v7

    invoke-virtual {v7}, Lcom/vzw/nfc/dos/VzwPermissionDo;->isVzwAllowed()Z

    move-result v7

    invoke-direct {v3, v0, v5, v6, v7}, Lcom/vzw/nfc/RouteEntry;-><init>([BIIZ)V

    .local v3, "entry":Lcom/vzw/nfc/RouteEntry;
    invoke-virtual {p2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .end local v0    # "aid":[B
    .end local v1    # "clf_FILTER_DO":Lcom/vzw/nfc/dos/ClfFilterDo;
    .end local v3    # "entry":Lcom/vzw/nfc/RouteEntry;
    .end local v5    # "powerState":I
    :cond_0
    return-void
.end method


# virtual methods
.method public disableFilterCondition(B)Z
    .locals 4
    .param p1, "filterConditionTag"    # B

    .prologue
    const/4 v2, 0x1

    .local v2, "status":Z
    const/16 v3, -0xf

    if-ne v3, p1, :cond_0

    :try_start_0
    invoke-static {}, Lcom/vzw/nfc/AidFilter;->getServiceInterface()Lcom/lge/nfcaddon/INfcAdapterNxp;

    move-result-object v1

    .local v1, "nfcAdapterNxp":Lcom/lge/nfcaddon/INfcAdapterNxp;
    if-eqz v1, :cond_1

    const/4 v3, 0x0

    invoke-interface {v1, v3}, Lcom/lge/nfcaddon/INfcAdapterNxp;->setScreenOffCondition(Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "nfcAdapterNxp":Lcom/lge/nfcaddon/INfcAdapterNxp;
    :cond_0
    :goto_0
    return v2

    .restart local v1    # "nfcAdapterNxp":Lcom/lge/nfcaddon/INfcAdapterNxp;
    :cond_1
    const/4 v2, 0x0

    goto :goto_0

    .end local v1    # "nfcAdapterNxp":Lcom/lge/nfcaddon/INfcAdapterNxp;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public enableFilterCondition(B)Z
    .locals 4
    .param p1, "filterConditionTag"    # B

    .prologue
    const/4 v2, 0x1

    .local v2, "status":Z
    const/16 v3, -0xf

    if-ne v3, p1, :cond_0

    :try_start_0
    invoke-static {}, Lcom/vzw/nfc/AidFilter;->getServiceInterface()Lcom/lge/nfcaddon/INfcAdapterNxp;

    move-result-object v1

    .local v1, "nfcAdapterNxp":Lcom/lge/nfcaddon/INfcAdapterNxp;
    if-eqz v1, :cond_1

    const/4 v3, 0x1

    invoke-interface {v1, v3}, Lcom/lge/nfcaddon/INfcAdapterNxp;->setScreenOffCondition(Z)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "nfcAdapterNxp":Lcom/lge/nfcaddon/INfcAdapterNxp;
    :cond_0
    :goto_0
    return v2

    .restart local v1    # "nfcAdapterNxp":Lcom/lge/nfcaddon/INfcAdapterNxp;
    :cond_1
    const/4 v2, 0x0

    goto :goto_0

    .end local v1    # "nfcAdapterNxp":Lcom/lge/nfcaddon/INfcAdapterNxp;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public setFilterList([B)Z
    .locals 7
    .param p1, "filterList"    # [B

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x1

    .local v4, "status":Z
    new-instance v0, Lcom/vzw/nfc/dos/ClfFilterDoList;

    array-length v6, p1

    invoke-direct {v0, p1, v5, v6}, Lcom/vzw/nfc/dos/ClfFilterDoList;-><init>([BII)V

    .local v0, "all_CLF_FILTER_DO":Lcom/vzw/nfc/dos/ClfFilterDoList;
    :try_start_0
    invoke-virtual {v0}, Lcom/vzw/nfc/dos/ClfFilterDoList;->translate()V
    :try_end_0
    .catch Lcom/vzw/nfc/dos/DoParserException; {:try_start_0 .. :try_end_0} :catch_0

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .local v2, "entries":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/vzw/nfc/RouteEntry;>;"
    invoke-direct {p0, v0, v2}, Lcom/vzw/nfc/AidFilter;->prepareRouteInfo(Lcom/vzw/nfc/dos/ClfFilterDoList;Ljava/util/ArrayList;)V

    :try_start_1
    invoke-static {}, Lcom/vzw/nfc/AidFilter;->getServiceInterface()Lcom/lge/nfcaddon/INfcAdapterNxp;

    move-result-object v3

    .local v3, "nfcAdapterNxp":Lcom/lge/nfcaddon/INfcAdapterNxp;
    if-eqz v3, :cond_0

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v5

    new-array v5, v5, [Lcom/vzw/nfc/RouteEntry;

    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [Lcom/vzw/nfc/RouteEntry;

    invoke-interface {v3, v5}, Lcom/lge/nfcaddon/INfcAdapterNxp;->setVzwAidList([Lcom/vzw/nfc/RouteEntry;)Z
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v4

    .end local v3    # "nfcAdapterNxp":Lcom/lge/nfcaddon/INfcAdapterNxp;
    :goto_0
    move v5, v4

    .end local v2    # "entries":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/vzw/nfc/RouteEntry;>;"
    :goto_1
    return v5

    :catch_0
    move-exception v1

    .local v1, "e":Lcom/vzw/nfc/dos/DoParserException;
    invoke-virtual {v1}, Lcom/vzw/nfc/dos/DoParserException;->printStackTrace()V

    goto :goto_1

    .end local v1    # "e":Lcom/vzw/nfc/dos/DoParserException;
    .restart local v2    # "entries":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/vzw/nfc/RouteEntry;>;"
    .restart local v3    # "nfcAdapterNxp":Lcom/lge/nfcaddon/INfcAdapterNxp;
    :cond_0
    const/4 v4, 0x0

    goto :goto_0

    .end local v3    # "nfcAdapterNxp":Lcom/lge/nfcaddon/INfcAdapterNxp;
    :catch_1
    move-exception v1

    .local v1, "e":Landroid/os/RemoteException;
    const/4 v4, 0x0

    goto :goto_0
.end method
